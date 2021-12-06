import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:flutter/material.dart';

import '../../../../di.dart';

Widget gridSearchResult(AsyncSnapshot<QuerySnapshot> snapshot, String query) {
  return GridView(
    padding: const EdgeInsets.all(5),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 2 / 2,
      crossAxisSpacing: 2,
      mainAxisSpacing: 10,
    ),
    children: [
      ...snapshot.data!.docs
          .where((QueryDocumentSnapshot<Object?> element) =>
              element['productName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .map((QueryDocumentSnapshot<Object?> data) {
        return InkWell(
          onTap: () {
            inject<Navigate>().navigateTo(
              ScreenConst.detailProduct,
              arguments: {
                'productId': data.id,
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
                      data['productPictureUrl'],
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
                        data['productName'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        formatPrice(data['productPrice']),
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
                              '${data['productProvince']}, ${data['productCity']}',
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
      }),
    ],
  );
}
