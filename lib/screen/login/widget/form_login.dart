import 'package:consignt/common/colors.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/screen/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'button_login.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return emailValidation(value);
                  },
                  decoration: textFormFieldDecoration('Email Address'),
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
                  obscureText: provider.obscurePassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (value) {
                    return passwordValidation(value);
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Password',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 12,
                    ),
                    suffixIcon: IconButton(
                      icon: FaIcon(
                        provider.obscurePassword
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: darkGrey,
                      ),
                      onPressed: () {
                        provider.obscurePassword
                            ? provider.setObscurePassword(false)
                            : provider.setObscurePassword(true);
                      },
                    ),
                  ),
                  style: textFormFieldStyle,
                ),
                const SizedBox(
                  height: 30,
                ),
                ButtonLogin(provider: provider),
              ],
            ),
          );
        },
      ),
    );
  }
}
