import 'package:consignt/common/navigate.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

void phoneNumberDialog(BuildContext context, ProfileProvider provider) {
  String temp = provider.phoneNumberTextField.text;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Name'),
        content: TextField(
          controller: provider.phoneNumberTextField,
          decoration: const InputDecoration(labelText: 'Name'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider.phoneNumberTextField.text = temp;
              inject<Navigate>().pop();
            },
            child: const Text('Discard'),
          ),
          TextButton(
            onPressed: () {
              provider.setPhoneNumber(provider.phoneNumberTextField.text);
              inject<Navigate>().pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
