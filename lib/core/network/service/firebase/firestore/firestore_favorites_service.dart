import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFavoriteService {
  static CollectionReference favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

  static Future<void> addFavoriteProduct(
    String userId,
    String productId,
  ) async {
    await favoritesCollection.add({
      'userId': userId,
      'productId': productId,
    });
  }

  static Future<void> deleteFavoriteProduct(
    String userId,
    String productId,
  ) async {
    var snapshot = await favoritesCollection
        .where('userId', isEqualTo: userId)
        .where('productId', isEqualTo: productId)
        .get();
    var docsId = snapshot.docs[0].id;
    favoritesCollection.doc(docsId).delete();
  }

  static Stream<QuerySnapshot> checkIsFavorite(
    String userId,
    String productId,
  ) {
    var snapshot = favoritesCollection
        .where('userId', isEqualTo: userId)
        .where('productId', isEqualTo: productId)
        .snapshots();

    return snapshot;
  }

  static Stream<QuerySnapshot> allFavoriteDataBasedOnUserId(String userId) {
    return favoritesCollection.where('userId', isEqualTo: userId).snapshots();
  }
}
