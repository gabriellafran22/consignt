import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreContactService {
  static CollectionReference contactCollection =
      FirebaseFirestore.instance.collection('contact');

  static Future<void> createContact(
    String userId,
    String? whatsappNumber,
    String? telegramUsername,
  ) async {
    await contactCollection.add({
      'userId': userId,
      'contactWhatsapp': whatsappNumber,
      'contactTelegram': telegramUsername,
    });
  }

  static Future<void> updateContact(
    String userId,
    String? whatsappNumber,
    String? telegramUsername,
  ) async {
    var snapshot =
        await contactCollection.where('userId', isEqualTo: userId).get();
    var documentId = snapshot.docs.first.id;

    Map<String, dynamic> data = {
      'contactTelegram': telegramUsername,
      'contactWhatsapp': whatsappNumber,
    };

    await contactCollection.doc(documentId).update(data);
  }

  static Future<Map<String, dynamic>> getContact(String userId) async {
    var snapshot =
        await contactCollection.where('userId', isEqualTo: userId).get();
    Map<String, dynamic> data = snapshot.docs[0].data() as Map<String, dynamic>;
    return data;
  }
}
