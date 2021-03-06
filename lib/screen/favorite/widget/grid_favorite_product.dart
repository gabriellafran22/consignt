import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

Widget gridFavoriteProduct(AsyncSnapshot<DocumentSnapshot> snapshotProduct) {
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                snapshotProduct.data!['productPictureUrl'],
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return loadingPicture(80, 80);
                },
                errorBuilder: (context, object, trace) {
                  return loadingPicture(80, 80);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshotProduct.data!['productName'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  formatPrice(
                    snapshotProduct.data!['productPrice'],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.location_on_sharp,
                      size: 16,
                    ),
                    Expanded(
                      child: Text(
                        '${snapshotProduct.data!['productProvince']}, ${snapshotProduct.data!['productCity']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
