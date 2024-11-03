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

  factory MessageDetails.fromJson(Map<String, dynamic> json,bool withOwner) {
    return MessageDetails(
      message: json["messageContent"],
      attachmentUrl: json["messageAttachmentUrl"] != null
          ? ApiManager.handleImageUrl(json["messageAttachmentUrl"])
          : null,
      timeStamp: DateTime.parse(json["timestamp"]).toLocal(),
      isPlayer: withOwner ? json["playerToOwner"] : json["adminToPlayer"],
    );
  }

  String jsonBody(bool withOwner) {
    String argumentsJson = jsonEncode([toJson()]);
    if(withOwner) {
      return '{"type":1, "target":"SendMessageFromPlayerToOwner", "arguments":$argumentsJson}';
    }
    return '{"type":1, "target":"SendMessageFromPlayerToAdmin", "arguments":$argumentsJson}';
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
