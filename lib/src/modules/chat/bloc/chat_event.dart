part of 'chat_bloc.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class SendMessageEvent extends ChatEvent {
  final MessageDetails message;
  final bool withOwner;

  const SendMessageEvent({required this.message,required this.withOwner});
}

class PickImageEvent extends ChatEvent {}

class StreamMessagesEvent extends ChatEvent {
  final bool withOwner;

  const StreamMessagesEvent({required this.withOwner});
}

class RemovePickedImageEvent extends ChatEvent {}

class GetConnectionEvent extends ChatEvent {
  // final bool withOwner;
  //
  // const GetConnectionEvent({required this.withOwner});
}

class CloseConnectionEvent extends ChatEvent {}

class GetAllChatsEvent extends ChatEvent {
  final bool withOwner;

  const GetAllChatsEvent({required this.withOwner});
}

class GetChatMessagesEvent extends ChatEvent {
  final int conversationId;
  final bool withOwner;

  GetChatMessagesEvent(
      {required this.withOwner,
      required this.conversationId,
      });
}

class ScrollingDownEvent extends ChatEvent {
  final ScrollController listScrollController;

  ScrollingDownEvent({required this.listScrollController});
}
