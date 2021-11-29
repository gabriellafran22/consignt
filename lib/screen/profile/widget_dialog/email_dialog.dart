import 'package:consignt/common/navigate.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

void emailDialog(BuildContext context, ProfileProvider provider) {
  String temp = provider.emailTextField.text;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Email'),
        content: TextField(
          controller: provider.emailTextField,
          decoration: const InputDecoration(labelText: 'Email'),
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
