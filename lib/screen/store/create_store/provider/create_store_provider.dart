import 'package:consignt/core/network/service/firebase/firestore/firestore_contact_service.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_user_service.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/cupertino.dart';

class CreateStoreProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  String _userId = '';

  TextEditingController whatsappController = TextEditingController();
  TextEditingController telegramController = TextEditingController();

  CreateStoreProvider({required this.preferencesHelper}) {
    _getUserId();
  }

  Future<void> _getUserId() async {
    final user = await preferencesHelper.userId;
    _userId = user;
    notifyListeners();
  }

  void updateIsSeller() {
    FirestoreUserService.updateIsSeller(_userId, true);
  }

  void createContact() {
    FirestoreContactService.createContact(
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
