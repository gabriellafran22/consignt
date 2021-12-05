import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/di.dart';
import 'package:consignt/screen/store/edit_store/provider/edit_store_provider.dart';
import 'package:consignt/screen/store/edit_store/widget/edit_form_contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditStoreScreen extends StatelessWidget {
  final String userId;

  const EditStoreScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditStoreProvider(userId),
      child: Consumer<EditStoreProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Store Settings',
                style: titleTextWhite,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    EditFormContact(
                      provider: provider,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(
                          'Save Changes',
                          style: titleTextWhite,
                        ),
                        style: fullyRoundedButton(),
                        onPressed: () {
                          provider.updateContact();
                          inject<Navigate>().pop();
                          showSnackBar(context, 'Contact Info Updated');
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
