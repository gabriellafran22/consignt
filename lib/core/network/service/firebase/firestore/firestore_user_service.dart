import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUserService {
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

  static Stream<DocumentSnapshot<Object?>> getUserStream(String id) {
    return userCollection.doc(id).snapshots();
  }

  static Future<Map<String, dynamic>> getUserFuture(String id) async {
     var snapshot =
        await userCollection.doc(id).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return data;
  }

  static Future<void> updateIsSeller(
    String? id,
    bool? isSeller,
  ) async {
    await userCollection.doc(id).set({
      'isSeller': isSeller,
      'createdUpdatedAt': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  }
}
