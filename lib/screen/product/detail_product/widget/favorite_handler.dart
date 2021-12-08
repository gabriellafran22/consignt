import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_favorites_service.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteHandler extends StatelessWidget {
  final String productId;

  const FavoriteHandler({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, _) {
        String userId = provider.userId;
        return StreamBuilder(
          stream: FirestoreFavoriteService.checkIsFavorite(
            userId,
            productId,
          ),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            } else {
              if (snapshot.data!.docs.isNotEmpty) {
                return IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    FirestoreFavoriteService.deleteFavoriteProduct(
                      userId,
                      productId,
                    );
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    FirestoreFavoriteService.addFavoriteProduct(
                      userId,
                      productId,
                    );
                  },
                );
              }
            }
          },
        );
      },
    );
  }
}
