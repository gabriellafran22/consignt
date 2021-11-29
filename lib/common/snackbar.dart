import 'package:consignt/common/styles.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: titleTextWhite,
      ),
    ),
  );
}
