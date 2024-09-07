import 'package:equatable/equatable.dart';
import 'package:hawihub/src/modules/chat/data/models/last_message.dart';

class Chat extends Equatable {
  final int playerId;
  final int conversationId;
  final LastMessage lastMessage;

  const Chat({
    required this.playerId,
    required this.conversationId,
    required this.lastMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      conversationId: json["conversationId"],
      playerId: json["playerId"],
      lastMessage: LastMessage.fromJson(json["lastMessage"]),
    );
  }

  static void sortChatsByDate(List<Chat> chats) {
    chats.sort(
        (a, b) => b.lastMessage.timestamp!.compareTo(a.lastMessage.timestamp!));
  }

  @override
  List<Object?> get props => [];
}
