import 'package:consignt/common/navigate.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

void nameDialog(BuildContext context, ProfileProvider provider) {
  String temp = provider.nameTextField.text;

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Name'),
        content: TextField(
          controller: provider.nameTextField,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider.nameTextField.text = temp;
              inject<Navigate>().pop();
            },
            child: const Text('Discard'),
          ),
          TextButton(
            onPressed: () {
              provider.setName(provider.nameTextField.text);
              inject<Navigate>().pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
