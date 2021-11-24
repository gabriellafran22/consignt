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
  }) async {
    await userCollection.doc(id).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'province': province,
      'city': city,
    });
  }
}
