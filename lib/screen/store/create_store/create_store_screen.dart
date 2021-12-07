import 'package:consignt/common/styles.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:consignt/screen/store/create_store/provider/create_store_provider.dart';
import 'package:consignt/screen/store/widget/form_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/dialog_open_store.dart';

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
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Start Selling',
                style: titleTextWhite,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    FormContact(
                      provider: provider,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(
                          'Start Selling',
                          style: titleTextWhite,
                        ),
                        style: fullyRoundedButton(),
                        onPressed: () {
                          confirmOpenStore(context, provider);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
