import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/cupertino.dart';

class CreateStoreProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  // String _userId = '';
  // String _name = '';
  // String _email = '';
  // String _phoneNumber = '';
  // String _province = '';
  // String _city = '';
  // String _profilePictureUrl = '';
  bool _isSeller = false;

  CreateStoreProvider({required this.preferencesHelper}) {
    _getUserInformation();
  }

  Future<void> _getUserInformation() async {
    final user = await preferencesHelper.userId;
    // _userId = user!.id!;
    // _name = user.name!;
    // _email = user.email!;
    // _phoneNumber = user.phoneNumber!;
    // _province = user.province!;
    // _city = user.city!;
    // _profilePictureUrl = user.profilePicture!;
    // _isSeller = user.isSeller!;

    notifyListeners();
  }

  void setIsSeller(bool tempIsSeller) {
    _isSeller = tempIsSeller;
    updateData();
    notifyListeners();
  }

  void updateData() {
    // FirestoreUserService.createOrUpdateUser(
    //   _userId,
    //   email: _email,
    //   name: _name,
    //   phoneNumber: _phoneNumber,
    //   province: _province,
    //   city: _city,
    //   profilePicture: _profilePictureUrl,
    //   isSeller: _isSeller,
    // );

    // UserModel user = UserModel(
    //   id: _userId,
    //   email: _email,
    //   name: _name,
    //   phoneNumber: _phoneNumber,
    //   province: _province,
    //   city: _city,
    //   profilePicture: _profilePictureUrl,
    //   isSeller: _isSeller,
    //   createdUpdatedAt: DateTime.now().toIso8601String(),
    // );

    _getUserInformation();
  }
}
