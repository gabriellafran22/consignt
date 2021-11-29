import 'package:consignt/common/navigate.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

void backDialog(BuildContext context, ProfileProvider provider) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Discard changes'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(
            onPressed: () {
              inject<Navigate>().pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              inject<Navigate>().pop();
              inject<Navigate>().pop();
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
