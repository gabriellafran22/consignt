import 'package:consignt/common/colors.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/screen/login/provider/login_provider.dart';

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Consumer<LoginProvider>(
                    builder: (context, provider, _) {
                      return Form(
                        key: provider.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: loginAndRegisterText,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: provider.emailController,
                              validator: (value) {
                                return emailValidation(value);
                              },
                              decoration:
                                  textFormFieldDecoration('Email Address'),
                              style: textFormFieldStyle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Password',
                              style: loginAndRegisterText,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: provider.passwordController,
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              validator: (value) {
                                return passwordValidation(value);
                              },
                              decoration: textFormFieldDecoration('Password'),
                              style: textFormFieldStyle,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton(
                                child: const Text('LOG IN'),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (provider.saveForm()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Account Logged in')));
                                    inject<Navigate>()
                                        .navigateTo(ScreenConst.home);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Failed')));
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
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
