import 'package:consignt/common/async.dart';
import 'package:consignt/core/custom_change_notifier.dart';
import 'package:consignt/core/model/province.dart';
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
