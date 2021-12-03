import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/screen/store/provider/create_store_provider.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

void confirmOpenStore(BuildContext context, CreateStoreProvider provider) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Open My Own Store'),
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
              provider.updateIsSeller(true);
              inject<Navigate>().pop();
              inject<Navigate>().pop();
              inject<Navigate>().navigateTo(
                ScreenConst.init,
                popPrevious: true,
              );
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
