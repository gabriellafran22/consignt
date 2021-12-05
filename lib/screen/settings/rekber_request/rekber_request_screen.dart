import 'package:consignt/common/colors.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RekBerRequest extends StatelessWidget {
  const RekBerRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RekBer Request',
          style: titleTextWhite,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please choose one of the admin below to help secure your transaction in CONSIGNT using RekBer (Rekening Bersama)',
                style: titleText16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: fullyRoundedButtonCustomColor(lightGreen),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        'WhatsApp Admin 1',
                        style: titleTextWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  launchInBrowser(
                    'https://api.whatsapp.com/send?phone=62895366331099',
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'or',
                style: titleText16,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: fullyRoundedButtonCustomColor(lightGreen),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const FaIcon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        'WhatsApp Admin 2',
                        style: titleTextWhite,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  launchInBrowser(
                    'https://api.whatsapp.com/send?phone=628112902206',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
