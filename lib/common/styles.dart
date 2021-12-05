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

TextStyle titleTextWhite = const TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

TextStyle titleText(double fontSize) => TextStyle(
  color: Colors.black,
  fontSize: fontSize,
  fontWeight: FontWeight.bold,
);

TextStyle contentTextWithLineSpacing = const TextStyle(
  color: Colors.black,
  fontSize: 16,
  height: 1.5,
);

TextStyle contentText16 = const TextStyle(
  color: Colors.black,
  fontSize: 16,
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

InputDecoration textFormFieldDecorationWithLabel(String labelText) =>
    InputDecoration(
      labelText: labelText,
      fillColor: Colors.white,
      filled: true,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 12,
      ),
    );

ButtonStyle fullyRoundedButton() => ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

ButtonStyle fullyRoundedButtonCustomColor(Color color) => ButtonStyle(
      backgroundColor: MaterialStateProperty.all(color),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
