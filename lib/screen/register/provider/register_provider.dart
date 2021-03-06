import 'package:consignt/common/async.dart';
import 'package:consignt/core/custom_change_notifier.dart';
import 'package:consignt/core/model/city.dart';
import 'package:consignt/core/model/province.dart';
import 'package:consignt/core/network/response/city_response.dart';
import 'package:consignt/core/network/response/province_response.dart';
import 'package:consignt/core/network/service/api/raja_ongkir_service.dart';
import 'package:consignt/core/network/service/firebase/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

class RegisterProvider extends CustomChangeNotifier {
  RegisterProvider() {
    getProvince();
  }

  final _rajaOngkirService = inject.get<RajaOngkirService>();

  Async<List<Province>> province = uninitialized<List<Province>>();
  Async<List<City>> city = uninitialized<List<City>>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRetypedController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  var hiddenCity = true;
  var provinceId = 0;
  var provinceName = '';
  var cityId = 0;
  var cityName = '';

  static String status = '';

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  Future<bool> saveForm() async {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      User? user = await AuthenticationService.signUp(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        province: provinceName,
        city: cityName,
      );
      if (user != null) {
        return true;
      } else {
        return false;
      }
    }
    return false;
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

  Future getCity(String provinceId) async {
    customApi(
      service: _rajaOngkirService.getCity(provinceId: provinceId),
      object: city,
      execute: (CityResponse response) {
        city.success(
          response.rajaongkir?.results ?? [],
        );
      },
    );
  }

  void setObscurePassword(bool temp){
    _obscurePassword = temp;
    notifyListeners();
  }

  void setObscureConfirmPassword(bool temp2){
    _obscureConfirmPassword = temp2;
    notifyListeners();
  }

  Future setProvince(Province? province) async {
    if (province == null) {
      provinceId = 0;
      provinceName = '';
      hiddenCity = true;
    } else {
      provinceId = int.parse(province.provinceId as String);
      provinceName = province.province as String;
      await getCity(provinceId.toString());
      hiddenCity = false;
    }
    notifyListeners();
  }

  void setCity(City? city) {
    if (city == null) {
      cityId = 0;
      cityName = '';
    } else {
      cityId = int.parse(city.cityId as String);
      cityName = '${city.type} ${city.cityName}';
    }
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordRetypedController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }
}
