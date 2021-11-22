import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about_screen';

  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/consignt_logo.jpg',
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
              //TODO: IF POSSIBLE, CLEAR CACHE BUTTON
            ],
          ),
        ),
      ),
    );
  }
}
