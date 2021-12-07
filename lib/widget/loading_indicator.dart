import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shimmer/shimmer.dart';

Widget loadingIndicator() {
  return Center(
    child: JumpingDotsProgressIndicator(
      fontSize: 40,
      color: Colors.blueGrey,
    ),
  );
}

Widget loadingPicture(double height, double width) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height,
      width: width,
      decoration: ShapeDecoration(
        color: Colors.grey[400]!,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  );
}
