import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  static Future<void> createOrUpdateUser(
    String? id, {
    String name = '',
    String phoneNumber = '',
    String province = '',
    String city = '',
    String profilePicture = '',
    bool isSeller = false,
  }) async {
    await userCollection.doc(id).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'province': province,
      'city': city,
      'profilePicture': profilePicture,
      'isSeller': isSeller,
      'createdUpdatedAt': DateTime.now().toIso8601String(),
    });
  }

  static Future<DocumentSnapshot> getUser(String? id) async {
    return await userCollection.doc(id).get();
  }
}
