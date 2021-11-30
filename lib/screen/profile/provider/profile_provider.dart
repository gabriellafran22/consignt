import 'package:consignt/common/async.dart';
import 'package:consignt/core/model/city.dart';
import 'package:consignt/core/model/province.dart';
import 'package:consignt/core/model/user.dart';
import 'package:consignt/core/network/response/city_response.dart';
import 'package:consignt/core/network/response/province_response.dart';
import 'package:consignt/core/network/service/api/raja_ongkir_service.dart';
import 'package:consignt/core/network/service/firebase/authentication_service.dart';
import 'package:consignt/core/network/service/firebase/firestore_service.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:consignt/core/custom_change_notifier.dart';

import '../../../di.dart';

class ProfileProvider extends CustomChangeNotifier {
  PreferencesHelper preferencesHelper;
  TextEditingController nameTextField = TextEditingController();
  TextEditingController emailTextField = TextEditingController();
  TextEditingController phoneNumberTextField = TextEditingController();
  TextEditingController provinceTextField = TextEditingController();
  TextEditingController cityTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();
  TextEditingController newPasswordTextField = TextEditingController();

  final _rajaOngkirService = inject.get<RajaOngkirService>();

  Async<List<Province>> province = uninitialized<List<Province>>();
  Async<List<City>> city = uninitialized<List<City>>();

  late String _userId;
  String profilePictureUrl = '';
  String initEmail = '';
  bool changeEmail = false;
  bool changePassword = false;
  bool isDataChanged = false;
  String provinceId = '0';

  ProfileProvider({required this.preferencesHelper}) {
    _getUserData();
    getProvince();
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

  Future getProvince() async {
    customApi(
      service: _rajaOngkirService.getProvince(),
      object: province,
      execute: (ProvinceResponse response) {
        province.success(
          response.rajaongkir?.results ?? [],
        );
      },
    );
  }

  Future getCity() async {
    customApi(
      service: _rajaOngkirService.getCity(provinceId: provinceId),
      object: province,
      execute: (CityResponse response) {
        city.success(
          response.rajaongkir?.results ?? [],
        );
      },
    );
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

  void setProvince(Province tempProvince) {
    provinceTextField.text = tempProvince.province ?? '';
    provinceId = tempProvince.provinceId ?? '0';
    isDataChanged = true;
    getCity();
    notifyListeners();
  }

  void setCity(City tempCity) {
    cityTextField.text = '${tempCity.type} ${tempCity.cityName}';
    isDataChanged = true;
    notifyListeners();
  }

  void setNewPassword(String tempNewPassword) {
    newPasswordTextField.text = tempNewPassword;
    changePassword = true;
    isDataChanged = true;
    notifyListeners();
  }

  Future<bool> checkPassword(String tempPassword) async {
    passwordTextField.text = tempPassword;
    AuthenticationService as = AuthenticationService();
    try {
      if (await as.authenticatePassword(initEmail, passwordTextField.text)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void updateData() {
    if (changeEmail) {
      AuthenticationService.updateEmail(
          emailTextField.text, initEmail, passwordTextField.text);
    }

    if (changePassword) {
      AuthenticationService.updatePassword(
          newPasswordTextField.text, initEmail, passwordTextField.text);
    }

    FirestoreService.createOrUpdateUser(
      _userId,
      email: emailTextField.text,
      name: nameTextField.text,
      phoneNumber: phoneNumberTextField.text,
      province: provinceTextField.text,
      city: cityTextField.text,
      profilePicture: '',
      isSeller: false,
    );

    UserModel user = UserModel(
      id: _userId,
      email: emailTextField.text,
      name: nameTextField.text,
      phoneNumber: phoneNumberTextField.text,
      province: provinceTextField.text,
      city: cityTextField.text,
      profilePicture: '',
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
    newPasswordTextField.dispose();
    super.dispose();
  }
}
