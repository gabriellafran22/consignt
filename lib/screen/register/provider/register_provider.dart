import 'package:consignt/common/async.dart';
import 'package:consignt/core/custom_change_notifier.dart';
import 'package:consignt/core/model/city.dart';
import 'package:consignt/core/model/province.dart';
import 'package:consignt/core/network/response/city_response.dart';
import 'package:consignt/core/network/response/province_response.dart';
import 'package:consignt/core/network/service/raja_ongkir_service.dart';
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

  var hiddenCity = true;
  var provinceId = 0;
  var cityId = 0;

  bool saveForm() {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      //TODO: create buyer account in firebase.
    }
    return isValid;
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
      service: _rajaOngkirService.getCity(provinceId),
      object: city,
      execute: (CityResponse response) {
        city.success(
          response.rajaongkir?.results ?? [],
        );
      },
    );
  }

  Future setProvince(Province? province) async {
    if (province == null) {
      provinceId = 0;
      hiddenCity = true;
    } else {
      provinceId = int.parse(province.provinceId as String);
      await getCity(provinceId.toString());
      hiddenCity = false;
    }
    notifyListeners();
  }

  void setCity(City? city) {
    if (city == null) {
      cityId = 0;
    } else {
      cityId = int.parse(city.cityId as String);
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
