import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:noob_chat/models/models.dart';

/// The class that manages the different chats
///  actions in the app
class ChatRepository {
  /// [FirebaseChatCore] instance
  final _fireChat = FirebaseChatCore.instance;

  /// Creats a one-to-one chat with the [otherUser]
  Future<types.Room> createRoom(User otherUser) {
    return _fireChat.createRoom(otherUser.toUser);
  }

  /// Get the stream of lists of chat rooms
  Stream<List<types.Room>> get chatRooms => _fireChat.rooms();

  /// Get the stream of lists of chat rooms
  Stream<List<types.User>> get users => _fireChat.users();

  /// Deletes a message with the [messageId] from
  /// the room with the [roomId]
  Future<void> deleteMessage(String roomId, String messageId) async {
    await _fireChat.deleteMessage(roomId, messageId);
  }

  /// Updates the given [message] in the
  /// chat [types.Room] with the given [roomId]
  Future<void> updateMessage(
    String roomId,
    types.Message message,
  ) async {
    _fireChat.updateMessage(message, roomId);
  }

  /// Sends a [message] to the [types.Room]
  ///  with the given [roomId]
  Future<void> sendMessage(
    String roomId,
    dynamic message,
  ) async {
    _fireChat.sendMessage(message, roomId);
  }

  /// deletes the [types.Room] with the [roomId] cmpletely
  Future<void> deleteRoom(String roomId) async {
    await _fireChat.deleteRoom(roomId);
  }

  /// returns a [types.Room] with the [roomId]
  Stream<types.Room> getRoom(String roomId) {
    return _fireChat.room(roomId);
  }

  /// returns list of messages in the [room]
  Stream<List<types.Message>> getMessages(types.Room room) {
    return _fireChat.messages(room);
  }
}

/// Conveinience extensions for [types.User]
extension FlutterChatTypeUserX on User {
  /// maps [User] to [types.User]
  types.User get toUser {
    return types.User(
      id: id,
      firstName: name,
      imageUrl: imageUrl,
      metadata: {
        'email': email,
      },
    );
  }
}

extension AppUserX on types.User {
  User get toAppUser {
    return User(
      id: id,
      name: firstName,
      imageUrl: imageUrl,
    );
  }
}
