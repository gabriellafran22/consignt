import 'package:consignt/ui/buyer/home_buyer_page.dart';
import 'package:consignt/ui/buyer/login_buyer_page.dart';
import 'package:consignt/ui/seller/login_seller_page.dart';
import 'package:consignt/ui/buyer/register_buyer_page.dart';
import 'package:consignt/ui/seller/register_seller_page.dart';
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
      ),
      initialRoute: LoginBuyerPage.routeName,
      routes: {
        LoginBuyerPage.routeName: (context) => const LoginBuyerPage(),
        RegisterBuyerPage.routeName: (context) => const RegisterBuyerPage(),
        HomeBuyerPage.routeName: (context) => const HomeBuyerPage(),
        LoginSellerPage.routeName: (context) => const LoginSellerPage(),
        RegisterSellerPage.routeName: (context) => const RegisterSellerPage(),
      },
    );
  }
}

