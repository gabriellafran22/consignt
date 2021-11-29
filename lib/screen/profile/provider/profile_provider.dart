import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier{
  TextEditingController nameTextField = TextEditingController();
  TextEditingController emailTextField = TextEditingController();
  TextEditingController phoneNumberTextField = TextEditingController();
  TextEditingController provinceTextField = TextEditingController();
  TextEditingController cityTextField = TextEditingController();

  ProfileProvider(){
    _getUserData();
  }

  void _getUserData(){
    //TODO: GET SEMUA DATA DARI USER MODEL
    nameTextField.text = 'my Name';
    emailTextField.text = 'email@mail.com';
    phoneNumberTextField.text = '122350444';
    provinceTextField.text = 'DKI Jakarta';
    cityTextField.text = 'Jakarta Pusat';
  }

  //TODO: YG SET INI BLM UPDATE KE FIREBASE
  void setName(String tempName){
    nameTextField.text = tempName;
    notifyListeners();
  }

  void setEmail(String tempEmail){
    emailTextField.text = tempEmail;
    notifyListeners();
  }

  void setPhoneNumber(String tempPhoneNumber){
    phoneNumberTextField.text = tempPhoneNumber;
    notifyListeners();
  }

  void setProvince(String tempProvince){
    provinceTextField.text = tempProvince;
    notifyListeners();
  }

  void setCity(String tempCity){
    cityTextField.text = tempCity;
    notifyListeners();
  }


}