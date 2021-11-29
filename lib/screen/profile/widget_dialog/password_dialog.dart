import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

void checkPasswordInPasswordDialog(
    BuildContext context, ProfileProvider provider) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Verify Password'),
        content: TextField(
          controller: provider.passwordTextField,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Verify Password'),
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
              if (await provider
                  .checkPassword(provider.passwordTextField.text)) {
                inject<Navigate>().pop();
                _passwordDialog(context, provider);
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

void _passwordDialog(BuildContext context, ProfileProvider provider) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('New Password'),
        content: TextField(
          controller: provider.newPasswordTextField,
          decoration: const InputDecoration(labelText: 'New Password'),
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            onPressed: () {
              provider.newPasswordTextField.clear();
              inject<Navigate>().pop();
            },
            child: const Text('Discard'),
          ),
          TextButton(
            onPressed: () {
              provider.setNewPassword(provider.newPasswordTextField.text);
              inject<Navigate>().pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
