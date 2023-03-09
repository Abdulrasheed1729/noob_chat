import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Object for the user of the app.
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.imageUrl,
    this.name,
    this.email,
  });

  ///
  factory User.fromDocument(DocumentSnapshot snap) {
    return User(
      id: snap['id'] as String,
      name: snap['name'] as String,
      email: snap['email'] as String,
      imageUrl: snap['imageUrl'] as String,
    );
  }

  ///
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  /// user's unique id
  final String id;

  /// User's email address
  final String? email;

  /// user name
  final String? name;

  /// user's picture url
  final String? imageUrl;

  /// Empty user instance
  static const empty = User(id: '');

  /// checks if user object is empty
  bool get isEmpty => this == User.empty;

  /// confirms that the current user object is not empty
  bool get isNotEmpty => this != User.empty;

  /// For Updates the user properties
  User copyWith({
    required String id,
    String? name,
    String? email,
    String? imageUrl,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  /// Converts user object to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  @override
  List<Object?> get props => [id, name, email, imageUrl];
}
