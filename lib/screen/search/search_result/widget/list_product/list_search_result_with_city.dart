import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/screen/search/search_result/provider/search_result_provider.dart';
import 'package:consignt/widget/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'list_product.dart';

Widget listSearchResultWithCity(
    AsyncSnapshot<QuerySnapshot> snapshot, String query, BuildContext context) {
  String city = context.read<SearchResultProvider>().cityTextField.text;

  if (snapshot.data!.docs
      .where((QueryDocumentSnapshot<Object?> element) => element['productName']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()))
      .where((QueryDocumentSnapshot<Object?> element) =>
          element['productCity'].toString().contains(city))
      .isEmpty) {
    return noProductsFound();
  }

  return ListView(
    padding: EdgeInsets.zero,
    children: [
      ...snapshot.data!.docs
          .where((QueryDocumentSnapshot<Object?> element) =>
              element['productName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .where((QueryDocumentSnapshot<Object?> element) =>
              element['productCity'].toString().contains(city))
          .map((QueryDocumentSnapshot<Object?> data) {
        return ListProduct(
          data: data,
        );
      }),
    ],
  );
}
