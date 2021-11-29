import 'package:consignt/core/model/user.dart';
import 'package:consignt/core/network/service/firebase/authentication_service.dart';
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
  TextEditingController passwordTextField = TextEditingController();

  late String _userId;
  String profilePictureUrl = '';
  String initEmail = '';
  bool changeEmail = false;
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

    initEmail = user.email!;
    notifyListeners();
  }

  void setName(String tempName) {
    nameTextField.text = tempName;
    isDataChanged = true;
    notifyListeners();
  }

  void setEmail(String tempEmail) {
    emailTextField.text = tempEmail;
    changeEmail = true;
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

  Future<bool> checkPassword(String tempPassword) async {
    passwordTextField.text = tempPassword;
    AuthenticationService as = AuthenticationService();
    try{
      if(await as.authenticatePassword(emailTextField.text, passwordTextField.text)){
        return true;
      }
      else{
        return false;
      }
    }
    catch(e){
      return false;
    }
  }

  void updateData() {
    if(changeEmail){
      AuthenticationService.updateEmail(emailTextField.text, initEmail, passwordTextField.text);
    }

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
    passwordTextField.dispose();
    super.dispose();
  }
}
