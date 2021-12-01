import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:consignt/screen/profile/widget_dialog/city_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/email_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/name_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/password_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/phone_number_dialog.dart';
import 'package:consignt/screen/profile/widget_dialog/province_dialog.dart';
import 'package:flutter/material.dart';

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
