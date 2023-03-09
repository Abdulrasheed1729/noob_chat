part of 'messages_bloc.dart';

class MessagesState extends Equatable {
  const MessagesState({
    this.status = MessagesStatus.initial,
    this.messages = const <type.Message>[],
    this.room,
    this.message,
  });

  final MessagesStatus status;
  final List<type.Message> messages;
  final type.Room? room;
  final dynamic message;

  MessagesState copyWith({
    List<type.Message> Function()? messages,
    type.Message Function()? message,
    MessagesStatus Function()? status,
    type.Room Function()? room,
  }) {
    return MessagesState(
      status: status != null ? status() : this.status,
      messages: messages != null ? messages() : this.messages,
      message: message != null ? message() : this.message,
      room: room != null ? room() : this.room,
    );
  }

  @override
  List<Object> get props => [status, messages];
}

enum MessagesStatus {
  initial,
  loading,
  success,
  failure,
}
