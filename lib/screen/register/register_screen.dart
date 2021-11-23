import 'package:consignt/common/colors.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/core/model/province.dart';
import 'package:consignt/screen/register/provider/register_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Consumer<RegisterProvider>(
                    builder: (context, provider, _) {
                      return Form(
                        key: provider.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name',
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
                              decoration: textFormFieldDecoration('Name'),
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
                              decoration:
                                  textFormFieldDecoration('Retype Password'),
                              style: textFormFieldStyle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Phone Number (081234567890)',
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
                              decoration:
                                  textFormFieldDecoration('Phone Number'),
                              style: textFormFieldStyle,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownSearch<Province>(
                              dropdownSearchDecoration:
                                  textFormFieldDecoration('Province'),
                              showClearButton: true,
                              showSearchBox: true,
                              searchBoxDecoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 25,
                                ),
                                hintText: "Province...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onFind: (text) async {
                                await provider.getProvince();
                                return provider.province.data ?? [];
                              },
                              onChanged: (value) {
                                if (value == null) {
                                  provider.provinceId = 0;
                                  provider.hiddenCity = true;
                                } else {
                                  provider.provinceId =
                                      int.parse(value.provinceId as String);
                                  provider.hiddenCity = false;
                                }
                              },
                              popupItemBuilder: (context, item, isSelected) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    "${item.province}",
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                );
                              },
                              itemAsString: (item) => item.province as String,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: ElevatedButton(
                                child: const Text('REGISTER'),
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
                                        content: Text('Account Registered'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Failed'),
                                      ),
                                    );
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
