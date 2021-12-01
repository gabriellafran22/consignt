import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/utils.dart';
import 'package:consignt/core/model/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirestoreProductService {
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  static Future<void> createOrUpdateProduct(
    String? productId,
    String? userId,
    String? productName,
    String productDescription,
    String productPrice,
    String productCategory,
    String productPicture,
    String productProvince,
    String productCity,
  ) async {
    await productCollection.doc(productId).set({
      'userId': userId,
      'productName': productName,
      'productDescription': productDescription,
      'productPrice': productPrice,
      'productCategory': productCategory,
      'productPicture': productPicture,
      'productProvince': productProvince,
      'productCity': productCity,
      'createdUpdatedAt': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  }

  static Future<DocumentSnapshot> getProductWithId(String id) async {
    return await productCollection.doc(id).get();
  }

  // static Future<String> uploadImage(File imageFile) async {
  //   String fileName = basename(imageFile.path);
  //
  //   Reference reference = FirebaseStorage.instance.ref().child(fileName);
  //   UploadTask task = reference.putFile(imageFile);
  //   TaskSnapshot snapshot = await task;
  //
  //   return await snapshot.ref.getDownloadURL();
  // }
}
