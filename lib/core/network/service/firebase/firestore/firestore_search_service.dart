import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/constant/sort_const.dart';

class FirestoreSearchService {
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  static Stream<QuerySnapshot> getAllProducts({String? sort}) {
    if (sort!.isEmpty) {
      return productCollection.snapshots();
    } else {
      if (sort == SortConst.priceHighToLow) {
        return productCollection
            .orderBy('productPrice', descending: true)
            .snapshots();
      } else if (sort == SortConst.priceLowToHigh) {
        return productCollection.orderBy('productPrice').snapshots();
      } else {
        return productCollection
            .orderBy('createdUpdatedAt', descending: true)
            .snapshots();
      }
    }
  }
}
