
import 'package:consignt/screen/about/about_screen.dart';
import 'package:consignt/screen/detail_product/detail_product_screen.dart';
import 'package:consignt/screen/home/home_screen.dart';
import 'package:consignt/screen/login/login_screen.dart';
import 'package:consignt/screen/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consignt',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        AboutScreen.routeName: (context) => AboutScreen(),
        DetailProductScreen.routeName: (context) => DetailProductScreen(),
      },
    );
  }
}

