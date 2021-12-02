
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProductService {
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  static Future<void> createOrUpdateProduct({
    required String productId,
    required String userId,
    required String productName,
    required String productDescription,
    required int productPrice,
    required String productCategory,
    required String productPicture,
    required String productProvince,
    required String productCity,
  }) async {
    await productCollection.doc(productId).set({
      'productId' : productId,
      'userId': userId,
      'productName': productName,
      'productDescription': productDescription,
      'productPrice': productPrice,
      'productCategory': productCategory,
      'productPictureUrl': productPicture,
      'productProvince': productProvince,
      'productCity': productCity,
      'createdUpdatedAt': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  }

  static Stream<QuerySnapshot> getAllProducts() {
    return productCollection.snapshots();
  }

  static Stream<QuerySnapshot> getAllUsersProducts(String userId) {
    return productCollection.where('userId', isEqualTo: userId)
        .snapshots();
  }

  static Stream<DocumentSnapshot> getProductDataWithId(String id) {
    return productCollection.doc(id).snapshots();
  }

}
