import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hawihub/src/core/apis/api.dart';

//ignore: must_be_immutable
class MessageDetails extends Equatable {
  final int? conversationId;
  final String? connectionId;
  final bool? isPlayer;
  String? message;
  String? attachmentUrl;
  final DateTime? timeStamp;
  String? voiceNoteUrl;

  MessageDetails({
    this.voiceNoteUrl,
    this.connectionId,
    this.conversationId,
    this.message,
    this.timeStamp,
    this.isPlayer,
    this.attachmentUrl,
  });

  factory MessageDetails.fromJson(Map<String, dynamic> json) {
    return MessageDetails(
      message: json["messageContent"],
      attachmentUrl: json["messageAttachmentUrl"] != null
          ? ApiManager.handleImageUrl(json["messageAttachmentUrl"])
          : null,
      timeStamp: DateTime.parse(json["timestamp"]),
      isPlayer: json["playerToOwner"],
    );
  }

  String jsonBody() {
    print(toJson());
    String argumentsJson = jsonEncode([toJson()]);
    return '{"type":1, "target":"SendMessageToOwner", "arguments":$argumentsJson}';
  }

  Map<String, dynamic> toJson() {
    return {
      "ConversationId": conversationId,
      "Message": message,
      "AttachmentUrl": attachmentUrl
    };
  }

  @override
  List<Object?> get props => [message, attachmentUrl];
}