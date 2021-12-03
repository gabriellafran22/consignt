import 'package:consignt/core/network/service/firebase/firestore/firestore_user_service.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/cupertino.dart';

class CreateStoreProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  String _userId = '';

  CreateStoreProvider({required this.preferencesHelper}) {
    _getUserId();
  }

  Future<void> _getUserId() async {
    final user = await preferencesHelper.userId;
    _userId = user;
    notifyListeners();
  }

  void updateIsSeller(bool tempIsSeller) {
    FirestoreUserService.updateIsSeller(_userId, tempIsSeller);
  }
}
