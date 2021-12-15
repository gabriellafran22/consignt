import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/screen/register/provider/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'button_register.dart';
import 'city_widget.dart';
import 'province_widget.dart';

class FormRegister extends StatelessWidget {
  const FormRegister({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<RegisterProvider>(
        builder: (context, provider, _) {
          return Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username',
                  style: loginAndRegisterText,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: provider.nameController,
                  validator: (value) {
                    return nameValidation(value);
                  },
                  decoration: textFormFieldDecoration('Username'),
                  style: textFormFieldStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
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
                  height: 5,
                ),
                TextFormField(
                  controller: provider.passwordRetypedController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  validator: (value) {
                    return passwordMatched(
                        provider.passwordController.text, value);
                  },
                  decoration: textFormFieldDecoration('Retype Password'),
                  style: textFormFieldStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Phone Number (08XXXXXXXXX)',
                  style: loginAndRegisterText,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: provider.phoneNumberController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    return phoneNumberValidation(value);
                  },
                  decoration: textFormFieldDecoration('Phone Number'),
                  style: textFormFieldStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Province',
                  style: loginAndRegisterText,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProvinceWidget(provider: provider),
                const SizedBox(
                  height: 10,
                ),
                provider.hiddenCity
                    ? const SizedBox()
                    : Text(
                        'City',
                        style: loginAndRegisterText,
                      ),
                const SizedBox(
                  height: 10,
                ),
                provider.hiddenCity
                    ? const SizedBox()
                    : CityWidget(provider: provider),
                const SizedBox(
                  height: 30,
                ),
                ButtonRegister(provider: provider),
              ],
            ),
          );
        },
      ),
    );
  }
}
