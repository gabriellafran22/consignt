import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  bool saveForm() {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      //TODO: navigate to homepage after check email & password in frebase.
    }
    return isValid;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
