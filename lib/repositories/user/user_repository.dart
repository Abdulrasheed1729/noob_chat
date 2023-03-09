import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:noob_chat/models/models.dart';

///
class UserRepository {
  final _collection = FirebaseFirestore.instance.collection('users');

  final _fireChat = FirebaseChatCore.instance;

  ///
  Stream<List<types.User>> get users => _fireChat.users();

  ///
  Future<void> addUserData(types.User user) async {
    await _fireChat.createUserInFirestore(
      // types.User(
      //   id: user.id,
      //   firstName: user.name,
      //   imageUrl: user.imageUrl,
      //   metadata: {
      //     'email': user.email,
      //   },
      // ),
      user,
    );
  }

  ///
  Future<void> deleteUser(String userId) async {
    await _fireChat.deleteUserFromFirestore(userId);
  }

  ///
  Future<void> updateUserData(
    User updatedUser, {
    Map<String, dynamic>? additionalData,
  }) async {
    await _collection.doc(updatedUser.id).get().then(
      (doc) async {
        final data = updatedUser.toJson();

        if (additionalData != null) data.addAll(additionalData);
        if (doc.exists) {
          // update
          await doc.reference.update(data);
        } else {
          await doc.reference.set(data);
        }
      },
    );
  }
}
