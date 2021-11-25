import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

Widget loadingIndicator(){
  return Center(
    child: JumpingDotsProgressIndicator(
      fontSize: 40,
      color: Colors.blueGrey,
    ),
  );
}