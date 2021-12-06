import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_product_service.dart';
import 'package:consignt/di.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:consignt/widget/product_grid_card.dart';
import 'package:consignt/widget/product_list_card.dart';
import 'package:consignt/widget/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, prefProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(top: 8),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search a product',
                  border: InputBorder.none,
                ),
                readOnly: true,
                onTap: () {
                  inject<Navigate>().navigateTo(ScreenConst.searchScreen);
                },
              ),
            ),
            actions: [
              IconButton(
                icon: prefProvider.isListView
                    ? const Icon(
                        Icons.format_list_bulleted,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.grid_view,
                        color: Colors.white,
                      ),
                onPressed: () {
                  if (prefProvider.isListView) {
                    prefProvider.setView(false);
                  } else {
                    prefProvider.setView(true);
                  }
                },
              ),
            ],
          ),
          body: StreamBuilder(
            stream: FirestoreProductService.getAllProducts(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
              if (snapshots.hasData) {
                if (snapshots.data!.docs.isEmpty) {
                  return noProductsFound();
                }
                return prefProvider.isListView
                    ? productListCard(snapshots)
                    : productGridCard(snapshots);
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}
