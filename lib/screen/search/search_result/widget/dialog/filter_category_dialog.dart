import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/product_category_const.dart';
import 'package:consignt/screen/search/search_result/provider/search_result_provider.dart';
import 'package:flutter/material.dart';

import '../../../../../../di.dart';

void filterCategoryDialog(BuildContext context, SearchResultProvider provider) async {
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
                  provider.setCategory(category);
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
