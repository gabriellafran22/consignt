import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

void showDialogDelete(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Delete Product',
          style: titleText16,
        ),
        content: const Text(
          'Are you sure, you want to delete this product?',
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
              //TODO: DELETE PRODUCT
              inject<Navigate>().pop();
              inject<Navigate>().pop();
            },
            child: const Text('Delete Product'),
          ),
        ],
      );
    },
  );
}
