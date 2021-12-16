import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:flutter/material.dart';

import '../../../../../di.dart';

class ListProduct extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> data;

  const ListProduct({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        shadowColor: Colors.blueGrey,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Image.network(
                data['productPictureUrl'],
                width: 80,
                height: 80,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                  if(loadingProgress == null){
                    return child;
                  }
                  return loadingPicture(80, 80);
                },
                errorBuilder: (context, object, trace){
                  return loadingPicture(80, 80);
                },
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
                      data['productName'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: contentText16,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      formatPrice(data['productPrice']),
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
                          '${data['productProvince']}, ${data['productCity']}',
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
}
