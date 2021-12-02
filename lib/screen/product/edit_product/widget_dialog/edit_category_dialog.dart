import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/product_category_const.dart';
import 'package:consignt/screen/product/edit_product/edit_product_provider/edit_product_provider.dart';
import 'package:flutter/material.dart';

import '../../../../di.dart';

void editCategoryDialog(BuildContext context, EditProductProvider provider) {
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
              var category = productCategoryList[index];
              return ListTile(
                title: Text(category),
                onTap: () {
                  provider.setProductCategory(category);
                  inject<Navigate>().pop();
                },
              );
            },
          ),
        ),
      );
    },
  );
}
