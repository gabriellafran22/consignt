import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/utils.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:flutter/material.dart';

Widget productDetail(BuildContext context, DocumentSnapshot? snapshot) {
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
                  style: titleText20,
                ),
                const Icon(Icons.favorite_border),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.productName,
              style: contentText18,
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
                style: contentText18,
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
                style: contentText18,
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
              style: titleText20,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.productDescription,
              style: contentText18,
            ),
          ],
        ),
      ),
    ],
  );
}
