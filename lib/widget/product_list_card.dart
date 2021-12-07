import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/utils.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/core/model/product.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:flutter/material.dart';

import '../di.dart';

ListView productListCard(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<ProductModel> allProduct = [];
  for (var item in snapshot.data!.docs) {
    Map<String, dynamic> data = item.data() as Map<String, dynamic>;
    ProductModel product = Utils.convertDocumentToProductModel(data);
    allProduct.add(product);
  }
  return ListView.builder(
    padding: const EdgeInsets.all(5),
    itemCount: allProduct.length,
    itemBuilder: (context, index) {
      var product = allProduct[index];
      return InkWell(
        onTap: () {
          inject<Navigate>().navigateTo(
            ScreenConst.detailProduct,
            arguments: {
              'productId': snapshot.data!.docs[index].id,
            },
          );
        },
        child: Card(
          shadowColor: Colors.blueGrey,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.network(
                  product.productPictureUrl,
                  width: 80,
                  height: 80,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                    if(loadingProgress == null){
                      return child;
                    }
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
                        product.productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: contentText16,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        formatPrice(product.productPrice),
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
                            '${product.productProvince}, ${product.productCity}',
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
    },
  );
}
