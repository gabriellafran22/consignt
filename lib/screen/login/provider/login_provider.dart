import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  void saveForm() {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      //TODO: navigate to homepage after check email & password in frebase.
      inject<Navigate>().navigateTo(ScreenConst.home);
    }
  }
}
