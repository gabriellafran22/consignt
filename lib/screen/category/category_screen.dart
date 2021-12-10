import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
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
        title: Text(
          'Category',
          style: titleTextWhite,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: productCategoryList.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.category),
                    const SizedBox(height: 10),
                    Text(
                      productCategoryList[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
