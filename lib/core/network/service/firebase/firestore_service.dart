import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirestoreService {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> createOrUpdateUser(
    String? id, {
    String? email = '',
    String name = '',
    String phoneNumber = '',
    String province = '',
    String city = '',
    String profilePicture = '',
    bool isSeller = false,
  }) async {
    await userCollection.doc(id).set({
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'province': province,
      'city': city,
      'profilePicture': profilePicture,
      'isSeller': isSeller,
      'createdUpdatedAt': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  }

  static Future<DocumentSnapshot> getUser(String? id) async {
    return await userCollection.doc(id).get();
  }

  static Future<String> uploadImage(File imageFile) async {
    String fileName = basename(imageFile.path);

    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask task = reference.putFile(imageFile);
    TaskSnapshot snapshot = await task;

    return await snapshot.ref.getDownloadURL();
  }
}
