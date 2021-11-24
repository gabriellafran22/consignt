import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:flutter/material.dart';

import '../di.dart';

Widget productListCard(BuildContext context) {
  return InkWell(
    onTap: () {
      inject<Navigate>().navigateTo(ScreenConst.detailProduct);
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(
              'assets/consignt_logo.jpg',
              width: 80,
              height: 80,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Product Name'),
                  Text('Product Price'),
                  Text('Product Seller Location'),
                ],
              ),
            ),
            const Icon(Icons.favorite_border),
          ],
        ),
      ),
    ),
  );
}
