part of 'messages_bloc.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

class MessagesListSubscriptionRequested extends MessagesEvent {
  const MessagesListSubscriptionRequested();

  @override
  List<Object> get props => [];
}

class TextMessageSent extends MessagesEvent {
  const TextMessageSent(this.message);
  final type.PartialText message;

  @override
  List<Object> get props => [message];
}

class ImageAttachmentMessageSent extends MessagesEvent {
  const ImageAttachmentMessageSent({this.message});

  final type.PartialImage? message;
  @override
  List<Object> get props => [];
}
