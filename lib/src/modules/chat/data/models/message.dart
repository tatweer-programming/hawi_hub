import 'package:equatable/equatable.dart';
import 'package:hawihub/src/modules/chat/data/models/message_details.dart';

class Message extends Equatable {
  final DateTime lastTimeToChat;
  final List<MessageDetails> message;

  const Message({
    required this.lastTimeToChat,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json,bool withOwner) {
    return Message(
      lastTimeToChat:
          DateTime.parse(json["lastTimeToChat"]).toLocal(),
      message: List<MessageDetails>.from(
        json["messages"]
            .map((message) => MessageDetails.fromJson(message,withOwner))
            .toList(),
      ),
    );
  }

  @override
  List<Object?> get props => [lastTimeToChat, message];
}
