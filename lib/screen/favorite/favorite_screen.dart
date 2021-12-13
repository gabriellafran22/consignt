import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_favorites_service.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_product_service.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:consignt/screen/favorite/widget/grid_favorite_product.dart';
import 'package:consignt/screen/favorite/widget/list_favorite_product.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:consignt/widget/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Favorite Products',
              style: titleTextWhite,
            ),
            actions: [
              IconButton(
                icon: provider.isListViewInFavorites
                    ? const Icon(
                        Icons.format_list_bulleted,
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.grid_view,
                        color: Colors.white,
                      ),
                onPressed: () {
                  if (provider.isListViewInFavorites) {
                    provider.setViewInFavorites(false);
                  } else {
                    provider.setViewInFavorites(true);
                  }
                },
              ),
            ],
          ),
          body: StreamBuilder(
            stream: FirestoreFavoriteService.allFavoriteDataBasedOnUserId(
              provider.userId,
            ),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
              if (snapshots.hasData) {
                if (snapshots.data!.docs.isEmpty) {
                  return noFavoriteProducts();
                }
                return provider.isListViewInFavorites
                    ? _myFavoritesList(snapshots)
                    : _myFavoritesGrid(snapshots);
              }

              return Container();
            },
          ),
        );
      },
    );
  }
}

ListView _myFavoritesList(AsyncSnapshot<QuerySnapshot> snapshot) {
  return ListView.builder(
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {
      var product = snapshot.data!.docs[index];
      return StreamBuilder(
        stream: FirestoreProductService.getProductDataWithIdStream(
            product['productId']),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshotProduct) {
          if (!snapshotProduct.hasData) {
            return loadingIndicator();
          }
          return listFavoriteProduct(snapshotProduct);
        },
      );
    },
  );
}

GridView _myFavoritesGrid(AsyncSnapshot<QuerySnapshot> snapshot) {
  return GridView.builder(
    padding: const EdgeInsets.all(5),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 2 / 2,
      crossAxisSpacing: 2,
      mainAxisSpacing: 5,
    ),
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {
      var product = snapshot.data!.docs[index];
      return StreamBuilder(
        stream: FirestoreProductService.getProductDataWithIdStream(
            product['productId']),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshotProduct) {
          if (!snapshotProduct.hasData) {
            return loadingIndicator();
          }
          return gridFavoriteProduct(snapshotProduct);
        },
      );
    },
  );
}
