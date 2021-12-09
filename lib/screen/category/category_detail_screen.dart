import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_product_service.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:consignt/widget/product_grid_card.dart';
import 'package:consignt/widget/product_list_card.dart';
import 'package:consignt/widget/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
          style: titleTextWhite,
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreProductService.getAllProductsCategory(category),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasData) {
            if (snapshots.data!.docs.isEmpty) {
              return noProductsFound();
            }
            return context.read<PreferencesProvider>().isListView
                ? productListCard(snapshots)
                : productGridCard(snapshots);
          }
          return Container();
        },
      ),
    );
  }
}
