import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:flutter/material.dart';

import '../di.dart';

dynamic productListCard(AsyncSnapshot<QuerySnapshot> snapshot) {
  return snapshot.data!.docs
      .map((doc) => InkWell(
            onTap: () {
              inject<Navigate>().navigateTo(ScreenConst.detailProduct);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.network(
                      doc['productPictureUrl'],
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
                            doc['productName'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Rp. ${doc['productPrice']}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                                '${doc['productProvince']}, ${doc['productCity']}',
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
          ))
      .toList();
}
