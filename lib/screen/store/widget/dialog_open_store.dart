import 'package:consignt/common/navigate.dart';
import 'package:consignt/screen/store/provider/create_store_provider.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

void confirmOpenStore(BuildContext context, CreateStoreProvider provider) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Start Selling'),
        content: const Text('Are you sure you want to start selling?'),
        actions: [
          TextButton(
            onPressed: () {
              inject<Navigate>().pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              provider.updateIsSeller();
              provider.createContact();
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
