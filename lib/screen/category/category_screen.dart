import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/product_category_const.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:flutter/material.dart';

import '../../di.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: productCategoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => inject<Navigate>().navigateTo(
                  ScreenConst.categoryDetail,
                  arguments: {
                    'category': productCategoryList[index],
                  },
                ),
                child: Text(
                  productCategoryList[index],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),
      ),
    );
  }
}
