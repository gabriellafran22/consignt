import 'package:consignt/common/styles.dart';
import 'package:consignt/screen/register/provider/register_provider.dart';
import 'package:flutter/material.dart';

class ButtonRegister extends StatelessWidget {
  const ButtonRegister({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final RegisterProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        child: Text(
          'REGISTER',
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
                content: Text('Account Registered, An email verification has been sent to your email'),
              ),
            );
            Navigator.pop(context);
          } else if (RegisterProvider.status.isNotEmpty){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(RegisterProvider.status.split(']').last),
              ),
            );
          } else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Data is not filled or Something went wrong'),
              ),
            );
          }
        },
      ),
    );
  }
}
