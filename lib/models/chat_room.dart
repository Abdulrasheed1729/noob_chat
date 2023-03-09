import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:noob_chat/models/models.dart';

/// Chat groups
class ChatRoom extends Equatable {
  /// {@macro chat_room}
  const ChatRoom(
    this.members, {
    required this.id,
    required this.name,
    this.messages,
  });

  ///
  factory ChatRoom.fromDocument(DocumentSnapshot snap) {
    return ChatRoom(
      snap['members'] as List<User>,
      id: snap['id'] as String,
      name: snap['name'] as String,
      messages: snap['messages'] as List<Message>,
    );
  }

  ///
  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      json['members'] as List<User>,
      name: json['name'] as String,
      id: json['id'] as String,
      messages: json['messages'] as List<Message>,
    );
  }

  /// Converts user object to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'members': members,
      'messages': messages,
    };
  }

  ///
  final String id;

  ///
  final String name;

  /// Chat room members
  final List<User> members;

  /// Chat room messages?
  final List<Message>? messages;

  @override
  List<Object?> get props => [id, members, members];
}

///
class SelectedChatroom {
  ///
  SelectedChatroom(this.id, this.displayName);

  ///
  final String id;

  ///
  final String displayName;
}
