import 'package:consignt/common/colors.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/core/network/service/firebase/authentication_service.dart';
import 'package:consignt/di.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  Future<bool> saveForm() async {
    final bool isValid = formKey.currentState!.validate();
    if (isValid) {
      await AuthenticationService.resetPassword(emailController.text);
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/consignt_logo_cropped.jpg',
                  ),
                  Center(
                    child: Text(
                      'RESET PASSWORD',
                      style: loginAndRegisterLargeText,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Enter your user email address',
                    style: loginAndRegisterText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => emailValidation(value),
                    decoration: textFormFieldDecoration('Email Address'),
                    style: textFormFieldStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'RESET PASSWORD',
                        style: titleText(16),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if(await saveForm()){
                          inject<Navigate>().pop();
                          showSnackBar(context, 'Reset Password has been sent to your email');
                        } else {
                          showSnackBar(context, 'Email address is not valid or Something went wrong, please try again');
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
