import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:consignt/screen/store/provider/create_store_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di.dart';

class CreateStoreScreen extends StatelessWidget {
  const CreateStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateStoreProvider(
        preferencesHelper: PreferencesHelper(
          sharedPreferences: SharedPreferences.getInstance(),
        ),
      ),
      child: Consumer<CreateStoreProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Create Store',
                style: titleTextWhite,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      'Open My Own Store',
                      style: titleTextWhite,
                    ),
                    style: fullyRoundedButton(),
                    onPressed: () {
                      confirmOpenStore(context, provider);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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
              provider.setIsSeller(true);
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
