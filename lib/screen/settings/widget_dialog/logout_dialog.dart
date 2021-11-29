import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/core/network/service/firebase/authentication_service.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import '../../../di.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Log Out',
          style: titleText16,
        ),
        content: const Text(
          'Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              inject<Navigate>().pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              AuthenticationService.signOut();
              context.read<PreferencesProvider>().removeUser();
              inject<Navigate>()
                  .navigateToRemoveUntil(ScreenConst.login, ScreenConst.login);
            },
            child: const Text('Log Out'),
          ),
        ],
      );
    },
  );
}
