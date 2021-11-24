import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/screen/login/provider/login_provider.dart';
import 'package:flutter/material.dart';

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
          style: titleText16,
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
          //TODO: JGN LUPA UNCOMMENT YG DI BAWAH (BIARIN GINI DLU BIAR GA CAPE INPUT EMAIL & PASSWORD)
          if (await provider.saveForm()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account Logged in'),
              ),
            );
            inject<Navigate>().navigateTo(
              ScreenConst.init,
              popPrevious: true,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(LoginProvider.status.split(']').last),
              ),
            );
          }
        },
      ),
    );
  }
}
