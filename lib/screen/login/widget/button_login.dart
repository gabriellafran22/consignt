import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:consignt/screen/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';

class ButtonLogin extends StatelessWidget {
  const ButtonLogin({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final LoginProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          'LOG IN',
          style: titleText(16),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: () async {
          if (await provider.saveForm()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account Logged in'),
              ),
            );
            context.read<PreferencesProvider>().getUserId();
            inject<Navigate>().navigateTo(
              ScreenConst.init,
              popPrevious: true,
            );
          } else if (LoginProvider.status.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(LoginProvider.status.split(']').last),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(LoginProvider.status),
              ),
            );
          }
        },
      ),
    );
  }
}
