import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/utils.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/core/model/product.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:flutter/material.dart';

import '../di.dart';
import 'loading_indicator.dart';

GridView productGridCard(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<ProductModel> allProduct = [];
  for (var item in snapshot.data!.docs) {
    Map<String, dynamic> data = item.data() as Map<String, dynamic>;
    ProductModel product = Utils.convertDocumentToProductModel(data);
    allProduct.add(product);
  }
  return GridView.builder(
    padding: const EdgeInsets.all(5),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 2 / 2,
      crossAxisSpacing: 2,
      mainAxisSpacing: 5,
    ),
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
                    product.productPictureUrl,
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
                      product.productName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      formatPrice(product.productPrice),
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
                            '${product.productProvince}, ${product.productCity}',
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
    },
  );
}
