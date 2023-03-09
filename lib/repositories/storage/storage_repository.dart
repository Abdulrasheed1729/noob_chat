import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

/// This is the class that handles operations for the
/// firebase storage repository e.
class StorageRepository {
  /// Getting the instance of the [FirebaseStorage] class
  FirebaseStorage storage = FirebaseStorage.instance;

  ///
  Future<String> uploadFile(String ref, File file) async {
    final storageRef = storage.ref().child(ref);
    final uploadTask = await storageRef.putFile(file);
    final downloadUrl = await uploadTask.ref.getDownloadURL();

    return downloadUrl;
  }

  ///
  Future<String> uploadImageData(String ref, Uint8List fileData) async {
    final storageRef = storage.ref().child(ref);
    final uploadTask = await storageRef.putData(fileData);
    final downloadUrl = await uploadTask.ref.getDownloadURL();

    return downloadUrl;
  }
}
