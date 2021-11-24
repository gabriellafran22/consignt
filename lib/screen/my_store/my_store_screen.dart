import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../di.dart';

class MyStoreScreen extends StatefulWidget {
  const MyStoreScreen({Key? key}) : super(key: key);

  @override
  _MyStoreScreenState createState() => _MyStoreScreenState();
}

class _MyStoreScreenState extends State<MyStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Products',
          style: titleTextWhite,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _productListCard(context),
          _productListCard(context),
          _productListCard(context),
          _productListCard(context),
          _productListCard(context),
          _productListCard(context),
          _productListCard(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const FaIcon(FontAwesomeIcons.plus),
        onPressed: () {
          //TODO: ADD PRODUCT (GA BUTUH PARAMETER DATA DARI PRODUCT)
          inject<Navigate>().navigateTo(ScreenConst.addEditProduct);
        },
      ),
    );
  }
}

Widget _productListCard(BuildContext context) {
  return InkWell(
    onTap: () {
      //TODO: EDIT PRODUCT SCREEN (BUTUH PARAMETER DATA DARI PRODUCT YANG DI KLIK)
      inject<Navigate>().navigateTo(ScreenConst.addEditProduct);
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
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
