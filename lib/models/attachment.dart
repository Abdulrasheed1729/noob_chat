import 'dart:typed_data';

import 'package:equatable/equatable.dart';

/// The object for the file attachment for a message
class AttachmentFile extends Equatable {
  /// {@macro attachment_file}
  const AttachmentFile({
    required this.size,
    this.bytes,
    this.name,
    this.path,
  });

  /// file size
  final int size;

  /// file's absolute path
  final String? path;

  /// file name
  final String? name;

  /// file bytes
  final Uint8List? bytes;

  /// An empty instance of a file
  static const empty = AttachmentFile(size: 0);

  /// Getter for checking if a file is empty
  bool get isEmpty => this == AttachmentFile.empty;

  /// Getter for confirming that a file is not empty
  bool get isNotEmpty => this != AttachmentFile.empty;

  @override
  List<Object?> get props => [name, bytes, size, path];
}
