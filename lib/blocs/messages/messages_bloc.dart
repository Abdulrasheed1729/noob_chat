import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as type;
import 'package:noob_chat/repositories/repositories.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc(this._chatRepository, this.room) : super(const MessagesState()) {
    on<MessagesListSubscriptionRequested>(_onMessagesListSubscriptionRequested);
    on<TextMessageSent>(_onTextMessageSent);
  }

  final ChatRepository _chatRepository;
  final type.Room room;

  FutureOr<void> _onMessagesListSubscriptionRequested(
    MessagesListSubscriptionRequested event,
    Emitter<MessagesState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => MessagesStatus.loading,
      ),
    );

    await emit.forEach(
      _chatRepository.getMessages(room),
      onData: (messages) => state.copyWith(
        status: () => MessagesStatus.success,
        messages: () => messages,
      ),
      onError: (_, __) => state.copyWith(
        status: () => MessagesStatus.failure,
      ),
    );
  }

  FutureOr<void> _onTextMessageSent(
    TextMessageSent event,
    Emitter<MessagesState> emit,
  ) async {
    final newMessage = event.message;

    await _chatRepository.sendMessage(room.id, newMessage);
  }
}
