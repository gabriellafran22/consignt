import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:consignt/screen/profile/widget/dialog/city_dialog.dart';
import 'package:consignt/screen/profile/widget/dialog/clear_search_history_dialog.dart';
import 'package:consignt/screen/profile/widget/dialog/email_dialog.dart';
import 'package:consignt/screen/profile/widget/dialog/name_dialog.dart';
import 'package:consignt/screen/profile/widget/dialog/password_dialog.dart';
import 'package:consignt/screen/profile/widget/dialog/phone_number_dialog.dart';
import 'package:consignt/screen/profile/widget/dialog/province_dialog.dart';
import 'package:consignt/screen/search/search/search_history_database/search_history_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final ProfileProvider provider;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        _listTile(
          'Name',
          provider.nameTextField.text,
          () {
            nameDialog(context, provider);
          },
        ),
        _listTile(
          'Email',
          provider.emailTextField.text,
          () {
            checkPasswordInEmailDialog(context, provider);
          },
        ),
        _listTile(
          'Phone Number',
          provider.phoneNumberTextField.text,
          () {
            phoneNumberDialog(context, provider);
          },
        ),
        const Divider(
          height: 10,
          thickness: 10,
        ),
        _listTile(
          'Province',
          provider.provinceTextField.text,
          () {
            provinceDialog(context, provider);
          },
        ),
        _listTile(
          'City',
          provider.cityTextField.text,
          () {
            cityDialog(context, provider);
          },
        ),
        const Divider(
          height: 10,
          thickness: 10,
        ),
        _listTile(
          'Change Password',
          '',
          () {
            checkPasswordInPasswordDialog(context, provider);
          },
        ),
        const Divider(
          height: 10,
          thickness: 10,
        ),
        Consumer<SearchHistoryDatabaseProvider>(
          builder: (context, dbProvider, _) {
            return _listTile(
              'Clear Search History',
              '',
                  () {
                clearSearchHistoryDialog(context, dbProvider);
              },
            );
          },
        ),
      ],
    );
  }
}

Widget _listTile(String leading, String title, void Function() dialog) {
  return ListTile(
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(leading),
    ),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: dialog,
  );
}
