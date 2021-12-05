import 'package:consignt/core/network/service/firebase/firestore/firestore_contact_service.dart';
import 'package:flutter/cupertino.dart';

class EditStoreProvider extends ChangeNotifier {
  TextEditingController whatsappController = TextEditingController();
  TextEditingController telegramController = TextEditingController();
  String _userId = '';

  EditStoreProvider(String userId) {
    _userId = userId;
    _fillContactData();
  }

  Future<void> _fillContactData() async {
    var data = await FirestoreContactService.getContact(_userId);
    whatsappController.text = data['contactWhatsapp'];
    telegramController.text = data['contactTelegram'];
    notifyListeners();
  }

  void updateContact() {
    FirestoreContactService.updateContact(
      _userId,
      whatsappController.text,
      telegramController.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    telegramController.dispose();
    whatsappController.dispose();
  }
}
