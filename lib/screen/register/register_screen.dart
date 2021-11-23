import 'package:consignt/common/colors.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/screen/register/provider/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/form_register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(),
      child: Scaffold(
        backgroundColor: darkGrey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/consignt_logo_cropped.jpg',
                ),
                Text(
                  'REGISTER AN ACCOUNT',
                  style: loginAndRegisterLargeText,
                ),
                const SizedBox(
                  height: 20,
                ),
                const FormRegister(),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: loginAndRegisterTextWithUnderline,
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
