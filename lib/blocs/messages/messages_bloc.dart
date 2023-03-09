import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as type;
import 'package:image_picker/image_picker.dart';
import 'package:noob_chat/repositories/repositories.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc(this._chatRepository, this.room, this._storageRepository)
      : super(const MessagesState()) {
    on<MessagesListSubscriptionRequested>(_onMessagesListSubscriptionRequested);
    on<TextMessageSent>(_onTextMessageSent);
    on<ImageAttachmentMessageSent>(_onImageAttachmentMessageSent);
  }

  final ChatRepository _chatRepository;
  final StorageRepository _storageRepository;
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

  FutureOr<void> _onImageAttachmentMessageSent(
    ImageAttachmentMessageSent event,
    Emitter<MessagesState> emit,
  ) async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final name = result.name;

      try {
        final uri = await _storageRepository.uploadImageData(name, bytes);
        final message = type.PartialImage(
          height: image.height.toDouble(),
          name: name,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        await _chatRepository.sendMessage(room.id, message);
      } catch (_) {}
    }
  }
}
