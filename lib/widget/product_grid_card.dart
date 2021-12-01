import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:flutter/material.dart';

import '../di.dart';

dynamic productGridCard(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs
      .map((doc) => InkWell(
            onTap: () {
              //TODO: LEMPAR DATA ID PRODUCT
              inject<Navigate>().navigateTo(ScreenConst.detailProduct);
            },
            child: Card(
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
                        doc['productPictureUrl'],
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
                          doc['productName'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Rp. ${doc['productPrice']}',
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
                                '${doc['productProvince']}, ${doc['productCity']}',
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
          ))
      .toList();
}
