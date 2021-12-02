import 'package:consignt/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget noProductsFound(){
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(FontAwesomeIcons.frownOpen, size: 50,),
          const SizedBox(height: 10,),
          Text('No Products Found', style: titleText20,),
        ],
      ),
    ),
  );
}

Widget noProductsAdded(){
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(FontAwesomeIcons.frownOpen, size: 50,),
          const SizedBox(height: 10,),
          Text('You Have Not Added Any Products', style: titleText20,),
        ],
      ),
    ),
  );
}

Widget pleaseCheckInternet(){
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded),
          const SizedBox(height: 10,),
          Text('Please Check Your Internet Connection', style: titleText20,),
        ],
      ),
    ),
  );
}