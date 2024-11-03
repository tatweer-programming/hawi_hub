import 'package:equatable/equatable.dart';
import 'package:hawihub/src/modules/chat/data/models/owner_chat.dart';


class LastMessage extends Equatable {
  final int? messageId;
  final String? messageContent;
  final String? messageAttachmentUrl;
  final bool? playerToOwner;
  final DateTime? timestamp;
  final OwnerChat? owner;

  const LastMessage({
    required this.messageId,
    required this.messageContent,
    required this.messageAttachmentUrl,
    required this.playerToOwner,
    required this.timestamp,
    required this.owner,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json,bool withOwner) {
    return LastMessage(
      messageId: json["messageId"],
      messageContent: json["messageContent"],
      messageAttachmentUrl: json["messageAttachmentUrl"],
      playerToOwner: withOwner ? json["playerToOwner"] : json["adminToPlayer"],
      timestamp: DateTime.parse(json["timestamp"]??DateTime.now().toLocal().toString()),
      owner: withOwner ? OwnerChat.fromJson(json["owner"]) : null,

    );
  }

  @override
  List<Object?> get props => [
    messageId,
  ];
}
