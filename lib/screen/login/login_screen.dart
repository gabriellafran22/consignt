import 'package:consignt/common/colors.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/screen/login/provider/login_provider.dart';
import 'package:consignt/screen/login/widget/form_login.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../di.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: Scaffold(
        backgroundColor: darkGrey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/consignt_logo_cropped.jpg',
                ),
                Text(
                  'LOGIN AN ACCOUNT',
                  style: loginAndRegisterLargeText,
                ),
                const SizedBox(
                  height: 20,
                ),
                const FormLogin(),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      inject<Navigate>().navigateTo(ScreenConst.register);
                    },
                    child: Text(
                      'Don’t have an account? Register',
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
