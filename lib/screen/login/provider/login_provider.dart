import 'package:consignt/core/model/user.dart';
import 'package:consignt/core/network/service/firebase/authentication_service.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  PreferencesHelper preferencesHelper = PreferencesHelper(
    sharedPreferences: SharedPreferences.getInstance(),
  );

  static String status = '';

  Future<bool> saveForm() async {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      UserModel? user = await AuthenticationService.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      if (user != null) {
        preferencesHelper.setUser(user);
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
