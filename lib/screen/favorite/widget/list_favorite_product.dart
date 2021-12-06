import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

Widget listFavoriteProduct(AsyncSnapshot<DocumentSnapshot> snapshotProduct) {
  return InkWell(
    onTap: () {
      inject<Navigate>().navigateTo(
        ScreenConst.detailProduct,
        arguments: {
          'productId': snapshotProduct.data!.id,
        },
      );
    },
    child: Card(
      elevation: 5,
      shadowColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              snapshotProduct.data!['productPictureUrl'],
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
                children: [
                  Text(
                    snapshotProduct.data!['productName'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: contentText16,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    formatPrice(
                      snapshotProduct.data!['productPrice'],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: contentText16,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_sharp,
                        size: 16,
                      ),
                      Text(
                        '${snapshotProduct.data!['productProvince']}, ${snapshotProduct.data!['productCity']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
