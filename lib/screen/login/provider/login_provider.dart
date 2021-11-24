import 'package:consignt/core/network/service/firebase/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  static String status = '';

  Future<bool> saveForm() async {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      User? user = await AuthenticationService.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      if (user != null) {
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
