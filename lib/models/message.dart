import 'package:equatable/equatable.dart';
import 'package:noob_chat/models/models.dart';

/// Object for message
class Message extends Equatable {
  /// {@macro message}
  const Message({
    required this.id,
    this.text,
    this.createdAt,
    this.user,
    this.attachmentFile,
  });

  /// {@macro message_from_json}
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      text: json['text'] as String,
      createdAt: json['createdAt'] as DateTime,
      user: json['user'] as User,
      attachmentFile: json['attachmentFile'] as AttachmentFile,
    );
  }

  ///
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'createdAt': createdAt,
      'user': user,
      'attachmentFile': attachmentFile,
    };
  }

  /// message unique id
  final String id;

  /// Message body
  final String? text;

  /// time of message creation
  final DateTime? createdAt;

  /// message sender
  final User? user;

  /// Attached file
  final AttachmentFile? attachmentFile;

  /// empty message object
  static const empty = Message(id: '');

  ///
  bool get isEmpty => this == Message.empty;

  ///
  bool get isNotEmpty => this != Message.empty;

  @override
  List<Object?> get props => [id, text, createdAt, user, attachmentFile];
}
