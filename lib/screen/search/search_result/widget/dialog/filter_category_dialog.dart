import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/product_category_const.dart';
import 'package:flutter/material.dart';

import '../../../../../../di.dart';

//TODO: MASIH ERROR
Future<String> filterCategoryDialog(BuildContext context) async {
  String temp = '';

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Product Category'),
        content: SizedBox(
          height: 300,
          width: 200,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: productCategoryList.length,
            itemBuilder: (BuildContext context, int index) {
              String category = productCategoryList[index];
              return ListTile(
                title: Text(category),
                onTap: () {
                  temp = category;
                  inject<Navigate>().pop();
                },
              );
            },
          ),
        ),
      );
    },
  );

  return temp;
}
