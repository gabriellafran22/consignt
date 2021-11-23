import 'package:consignt/common/styles.dart';
import 'package:flutter/material.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Check Shipping Fees',
          style: titleTextWhite,
        ),
      ),
      body: Container(
          //TODO: SHIPPING PRICES
          ),
    );
  }
}
