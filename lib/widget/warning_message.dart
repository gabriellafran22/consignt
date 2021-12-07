import 'package:consignt/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget noProductsFound() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.frownOpen,
            size: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'No Products Found',
            style: titleText(20),
          ),
        ],
      ),
    ),
  );
}

Widget noProductsAdded() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.frownOpen,
            size: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'You Have Not Added Any Products',
            style: titleText(20),
          ),
        ],
      ),
    ),
  );
}

Widget noFavoriteProducts() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.frownOpen,
            size: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'You Have Not Added Any Products to Favorites',
            style: titleText(20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget pleaseCheckInternet() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            size: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Please Check Your \nInternet Connection ☹',
            style: titleText(20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget searchProductMessage() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            size: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Search a product',
            style: titleText(20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
