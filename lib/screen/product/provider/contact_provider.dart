import 'package:consignt/common/utils.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_contact_service.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_product_service.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_user_service.dart';
import 'package:flutter/cupertino.dart';

class ContactProvider extends ChangeNotifier {
  String userId = '';
  String phoneNumber = '';
  String whatsappNumber = '';
  String telegramUsername = '';

  Future<void> getContact(String productId) async {
    var snapshot =
        await FirestoreProductService.getProductDataWithIdFuture(productId);
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    var product = Utils.convertDocumentToProductModel(data);
    userId = product.userId;
    getContactFromUser();
    getContactFromContact();
  }

  Future<void> getContactFromUser() async {
    var data = await FirestoreUserService.getUserFuture(userId);
    phoneNumber = data['phoneNumber'];
  }

  Future<void> getContactFromContact() async {
    var data = await FirestoreContactService.getContact(userId);
    whatsappNumber = data['contactWhatsapp'];
    telegramUsername = data['contactTelegram'];
  }
}
