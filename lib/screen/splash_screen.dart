import 'dart:async';

import 'package:consignt/common/colors.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:flutter/material.dart';

import '../di.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => inject<Navigate>().navigateTo(ScreenConst.login, replace: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            'assets/consignt_logo.jpg',
          ),
        ),
      ),
    );
  }
}
