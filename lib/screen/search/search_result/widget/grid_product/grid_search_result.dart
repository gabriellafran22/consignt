import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/screen/search/search_result/provider/search_result_provider.dart';
import 'package:consignt/screen/search/search_result/widget/grid_product/grid_product.dart';
import 'package:consignt/screen/search/search_result/widget/grid_product/grid_search_result_with_city.dart';
import 'package:consignt/widget/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

Widget gridSearchResult(
    AsyncSnapshot<QuerySnapshot> snapshot, String query, BuildContext context) {
  String city = context.read<SearchResultProvider>().cityTextField.text;

  if (snapshot.data!.docs
      .where((QueryDocumentSnapshot<Object?> element) => element['productName']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()))
      .isEmpty) {
    return noProductsFound();
  } else if (city != 'City') {
    return gridSearchResultWithCity(snapshot, query, context);
  }

  return GridView(
    padding: const EdgeInsets.all(5),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 2 / 2,
      crossAxisSpacing: 2,
      mainAxisSpacing: 5,
    ),
    children: [
      ...snapshot.data!.docs
          .where((QueryDocumentSnapshot<Object?> element) =>
              element['productName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .map((QueryDocumentSnapshot<Object?> data) {
        return GridProduct(data: data);
      }),
    ],
  );
}
