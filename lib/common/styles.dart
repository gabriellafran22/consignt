import 'package:flutter/material.dart';

TextStyle loginAndRegisterText = const TextStyle(
  color: Colors.white,
  fontSize: 14,
  fontWeight: FontWeight.bold,
);

TextStyle loginAndRegisterLargeText = const TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle loginAndRegisterTextWithUnderline = const TextStyle(
  color: Colors.white,
  fontSize: 14,
  decoration: TextDecoration.underline,
);

TextStyle textFormFieldStyle = const TextStyle(
  fontSize: 14,
);

InputDecoration textFormFieldDecoration(String hintText) => InputDecoration(
      fillColor: Colors.white,
      filled: true,
      hintText: hintText,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 12,
      ),
    );

TextStyle titleTextWhite = const TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.bold
);

TextStyle titleText = const TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
