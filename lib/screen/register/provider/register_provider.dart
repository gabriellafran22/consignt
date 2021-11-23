import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRetypedController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  bool saveForm() {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      //TODO: create buyer account in firebase.
    }
    return isValid;
  }
}
