import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/core/model/product.dart';

class FirestoreProductService {
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');
  static CollectionReference favoriteCollection =
      FirebaseFirestore.instance.collection('favorites');

  static Future<void> updateProduct({
    required String productId,
    required String userId,
    required String productName,
    required String productDescription,
    required int productPrice,
    required String productCategory,
    required String productPictureUrl,
    required String productProvince,
    required String productCity,
  }) async {
    ProductModel product = ProductModel(
      userId: userId,
      productName: productName,
      productDescription: productDescription,
      productPrice: productPrice,
      productCategory: productCategory,
      productPictureUrl: productPictureUrl,
      productProvince: productProvince,
      productCity: productCity,
      createdUpdatedAt: DateTime.now().toIso8601String(),
    );
    await productCollection.doc(productId).update(product.toJson());
  }

  static Future<void> addProduct({
    required String userId,
    required String productName,
    required String productDescription,
    required int productPrice,
    required String productCategory,
    required String productPictureUrl,
    required String productProvince,
    required String productCity,
  }) async {
    ProductModel product = ProductModel(
      userId: userId,
      productName: productName,
      productDescription: productDescription,
      productPrice: productPrice,
      productCategory: productCategory,
      productPictureUrl: productPictureUrl,
      productProvince: productProvince,
      productCity: productCity,
      createdUpdatedAt: DateTime.now().toIso8601String(),
    );
    await productCollection.add(product.toJson());
  }

  static Future<void> deleteProduct({
    required String productId,
  }) async {
    await productCollection.doc(productId).delete();
    QuerySnapshot deleteFavorite = await favoriteCollection.where('productId', isEqualTo: productId).get();
    deleteFavorite.docs.forEach((doc) async {
      await favoriteCollection.doc(doc.id).delete();
    });
  }

  static Stream<QuerySnapshot> getAllProducts() {
    return productCollection.snapshots();
  }

  static Stream<QuerySnapshot> getAllUsersProducts(String userId) {
    return productCollection.where('userId', isEqualTo: userId).snapshots();
  }

  static Stream<DocumentSnapshot> getProductDataWithIdStream(String id) {
    return productCollection.doc(id).snapshots();
  }

  static Future<DocumentSnapshot> getProductDataWithIdFuture(String id) async {
    return await productCollection.doc(id).get();
  }

  static Stream<QuerySnapshot> getAllProductsCategory(String category) {
    return productCollection
        .where('productCategory', isEqualTo: category)
        .snapshots();
  }
}
