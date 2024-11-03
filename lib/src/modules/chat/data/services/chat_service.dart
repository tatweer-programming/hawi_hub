import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/apis/dio_helper.dart';
import 'package:hawihub/src/core/apis/end_points.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/chat/data/models/chat.dart';
import 'package:hawihub/src/modules/chat/data/models/connection.dart';
import 'package:hawihub/src/modules/chat/data/models/message_details.dart';

import '../models/message.dart';

class ChatService {
  WebSocket? socket;

  Future<Either<String, Unit>> connection() async {
    try {
      Response response = await DioHelper.postData(
        path: EndPoints.getConnection,
        data: {},
      );
      if (response.statusCode == 200) {
        Connection connection = Connection.fromJson(response.data);
        ConstantsManager.connectionToken = connection.token;
        ConstantsManager.connectionId = connection.id;
        await _startConnection();
        await _addConnectionId();
        return const Right(unit);
      }
      return Left(response.data.toString());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Unit>> _addConnectionId() async {
    try {
      Response response = await DioHelper.postData(
        path: EndPoints.addConnectionId + ConstantsManager.userId.toString(),
        data: {
          "playerConnectionId": ConstantsManager.connectionId.toString(),
        },
      );
      if (response.statusCode == 200) {
        return response.data['message'];
      }
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Chat>>> getAllChats(
      {required bool withOwner}) async {
    try {
      Response response = await DioHelper.getData(
        path: (withOwner
                ? EndPoints.getPlayerConversationsWithOwners
                : EndPoints.getPlayerConversationsWithAdmins) +
            ConstantsManager.userId.toString(),
      );
      if (response.statusCode == 200) {
        List<Chat> chats = [];
        for (var item in response.data) {
          print(item);
          chats.add(Chat.fromJson(item!, withOwner));
        }
        return Right(chats);
      }
      return Left(response.data.toString());
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<Either<String, Unit>> sendMessage(
      {required MessageDetails message, required bool withOwner}) async {
    try {
      if (message.attachmentUrl != null) {
        message.attachmentUrl =
            await uploadFile(message.attachmentUrl!, message.conversationId!);
        message.message = null;
      }
      socket!.add(message.jsonBody(withOwner));
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Stream<MessageDetails> streamMessage({required bool withOwner}) {
    try {
      StreamController<MessageDetails> messageStreamController =
          StreamController<MessageDetails>.broadcast();
      socket!.listen((data) {
        if (data != '{"type":6}' && data != '{}') {
          String message =
              data.toString().replaceAll(RegExp(r'[\x00-\x1F]+'), '');
          final Map<String, dynamic> jsonData = jsonDecode(message);
          if (withOwner) {
            messageStreamController.add(MessageDetails(
              message: jsonData["arguments"][0]["ownerMessage"],
              attachmentUrl: jsonData["arguments"][0]["ownerAttachmentUrl"],
              isPlayer: false,
              timeStamp: DateTime.now().toUtc(),
            ));
          } else {
            messageStreamController.add(MessageDetails(
              message: jsonData["arguments"][0]["adminMessage"],
              attachmentUrl: jsonData["arguments"][0]["adminAttachmentUrl"],
              isPlayer: false,
              timeStamp: DateTime.now().toUtc(),
            ));
          }
        }
      });
      return messageStreamController.stream;
    } catch (e) {
      return const Stream.empty();
    }
  }

  Future<Either<String, Message>> getChatMessages(
      int conversationId, bool withOwner) async {
    try {
      Response response = await DioHelper.getData(
        path: (withOwner
                ? EndPoints.getConversationOwnerWithPlayer
                : EndPoints.getConversationAdminWithPlayer) +
            conversationId.toString(),
      );
      if (response.statusCode == 200) {
        Message messages = Message.fromJson(response.data, withOwner);
        return Right(messages);
      }
      return Left(response.data.toString());
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }

  Future<String> uploadFile(String filePath, int conversationId) async {
    try {
      FormData formData = FormData.fromMap({
        "ConversationId": conversationId.toString(),
        "ConversationAttachment": MultipartFile.fromFileSync(filePath),
      });
      Response response = await DioHelper.postFormData(
          EndPoints.uploadConversationAttachment, formData);
      if (response.statusCode == 200) {
        return response.data['conversationImageUrl'];
      }
      return response.data.toString();
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<void> _startConnection() async {
    await closeConnection();
    const String messageWithTrailingChars = '{"protocol":"json","version":1}';
    socket = await WebSocket.connect(
        "${ApiManager.webSocket}?id=${ConstantsManager.connectionToken!}");
    socket!.add(messageWithTrailingChars);
  }

  Future<void> closeConnection() async {
    if (socket != null) {
      await socket!
          .close(WebSocketStatus.normalClosure, 'Disconnected by client');
      socket = null;
    }
  }
}
