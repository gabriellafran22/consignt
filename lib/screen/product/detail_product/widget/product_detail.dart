import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/utils.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:flutter/material.dart';

import 'favorite_handler.dart';

Widget productDetail(
    BuildContext context, DocumentSnapshot? snapshot, String productId) {
  Map<String, dynamic> data = snapshot?.data() as Map<String, dynamic>;
  var product = Utils.convertDocumentToProductModel(data);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        color: Colors.black,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: Center(
          child: product.productPictureUrl == ''
              ? Image.asset('assets/consignt_logo_cropped')
              : Image.network(product.productPictureUrl),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatPrice(product.productPrice),
                  style: titleText(20),
                ),
                FavoriteHandler(productId: productId),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.productName,
              style: contentTextWithLineSpacing,
            ),
          ],
        ),
      ),
      const Divider(
        height: 5,
        thickness: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_sharp,
              size: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                '${product.productProvince}, ${product.productCity}',
                style: contentTextWithLineSpacing,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          children: [
            const Icon(
              Icons.category_rounded,
              size: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                product.productCategory,
                style: contentTextWithLineSpacing,
              ),
            ),
          ],
        ),
      ),
      const Divider(
        height: 15,
        thickness: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: titleText(20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.productDescription,
              style: contentTextWithLineSpacing,
            ),
          ],
        ),
      ),
    ],
  );
}
