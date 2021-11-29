import 'package:consignt/core/model/user.dart';
import 'package:consignt/core/network/service/firebase/firestore_service.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
  TextEditingController nameTextField = TextEditingController();
  TextEditingController emailTextField = TextEditingController();
  TextEditingController phoneNumberTextField = TextEditingController();
  TextEditingController provinceTextField = TextEditingController();
  TextEditingController cityTextField = TextEditingController();
  late String _userId;
  late String profilePictureUrl;
  bool isDataChanged = false;

  ProfileProvider({required this.preferencesHelper}) {
    _getUserData();
  }

  Future<void> _getUserData() async {
    final user = await preferencesHelper.user;
    _userId = user!.id!;
    nameTextField.text = user.name!;
    emailTextField.text = user.email!;
    phoneNumberTextField.text = user.phoneNumber!;
    provinceTextField.text = user.province!;
    cityTextField.text = user.city!;
    profilePictureUrl = user.profilePicture!;
    notifyListeners();
  }

  void setName(String tempName) {
    nameTextField.text = tempName;
    isDataChanged = true;
    notifyListeners();
  }

  void setEmail(String tempEmail) {
    emailTextField.text = tempEmail;
    isDataChanged = true;
    notifyListeners();
  }

  void setPhoneNumber(String tempPhoneNumber) {
    phoneNumberTextField.text = tempPhoneNumber;
    isDataChanged = true;
    notifyListeners();
  }

  void setProvince(String tempProvince) {
    provinceTextField.text = tempProvince;
    isDataChanged = true;
    notifyListeners();
  }

  void setCity(String tempCity) {
    cityTextField.text = tempCity;
    isDataChanged = true;
    notifyListeners();
  }

  void updateData() {
    //TODO: kalo change email pas authentication dia ga ke change
    FirestoreService.createOrUpdateUser(
      _userId,
      email: emailTextField.text,
      name: nameTextField.text,
      phoneNumber: phoneNumberTextField.text,
      province: provinceTextField.text,
      city: cityTextField.text,
      profilePicture: 'https://via.placeholder.com/150',
      isSeller: false,
    );

    UserModel user = UserModel(
      id: _userId,
      email: emailTextField.text,
      name: nameTextField.text,
      phoneNumber: phoneNumberTextField.text,
      province: provinceTextField.text,
      city: cityTextField.text,
      profilePicture: 'https://via.placeholder.com/150',
      isSeller: false,
      createdUpdatedAt: DateTime.now().toIso8601String(),
    );

    preferencesHelper.setUser(user);
    _getUserData();
  }

  @override
  void dispose() {
    nameTextField.dispose();
    emailTextField.dispose();
    phoneNumberTextField.dispose();
    provinceTextField.dispose();
    cityTextField.dispose();
    super.dispose();
  }
}
