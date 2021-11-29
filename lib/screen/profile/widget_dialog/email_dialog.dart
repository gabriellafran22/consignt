import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

void passwordDialog(BuildContext context, ProfileProvider provider) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Password'),
        content: TextField(
          controller: provider.passwordTextField,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Password'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              inject<Navigate>().pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (await provider.checkPassword(provider.passwordTextField.text)) {
                inject<Navigate>().pop();
                _emailDialog(context, provider);
              } else {
                showSnackbar(context, 'Wrong Password');
              }
            },
            child: const Text('Continue'),
          ),
        ],
      );
    },
  );
}

void _emailDialog(BuildContext context, ProfileProvider provider) {
  String temp = provider.emailTextField.text;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Email'),
        content: TextField(
          controller: provider.emailTextField,
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider.emailTextField.text = temp;
              inject<Navigate>().pop();
            },
            child: const Text('Discard'),
          ),
          TextButton(
            onPressed: () {
              provider.setEmail(provider.emailTextField.text);
              inject<Navigate>().pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
