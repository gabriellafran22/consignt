import 'package:consignt/common/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: titleTextWhite,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/consignt_logo.png',
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Version 1.0.0'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Consignt is a marketplace for used electronic products that people want to sell easily.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
