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
}
