import 'package:consignt/core/network/service/firebase/authentication_service.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  final GlobalKey<FormState> formKey = GlobalKey();

  PreferencesHelper preferencesHelper = PreferencesHelper(
    sharedPreferences: SharedPreferences.getInstance(),
  );

  static String status = '';

  bool get obscurePassword => _obscurePassword;

  Future<bool> saveForm() async {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      User? user = await AuthenticationService.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      if (user != null) {
        if(user.emailVerified){
          preferencesHelper.setUserId(user.uid);
          return true;
        }
        status = 'Email have not been verified, please check your email';
        return false;
      } else {
        status = 'Username or password is incorrect';

        return false;
      }


    }
    status = 'Something went wrong, please try again';

    return false;
  }

  void setObscurePassword(bool temp){
    _obscurePassword = temp;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
