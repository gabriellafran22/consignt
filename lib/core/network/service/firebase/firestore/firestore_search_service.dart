import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/constant/sort_const.dart';

class FirestoreSearchService {
  static CollectionReference productCollection =
      FirebaseFirestore.instance.collection('products');

  static Stream<QuerySnapshot> getAllProductsWithQueryOrSort(
      {String? sort, int? minPrice, int? maxPrice}) {
    if (sort!.isEmpty) {
      return productCollection
          .where('productPrice', isGreaterThanOrEqualTo: minPrice)
          .where('productPrice', isLessThanOrEqualTo: maxPrice)
          .snapshots();
    } else {
      if (sort == SortConst.priceHighToLow) {
        return productCollection
            .where('productPrice', isGreaterThanOrEqualTo: minPrice)
            .where('productPrice', isLessThanOrEqualTo: maxPrice)
            .orderBy('productPrice', descending: true)
            .snapshots();
      } else if (sort == SortConst.priceLowToHigh) {
        return productCollection
            .where('productPrice', isGreaterThanOrEqualTo: minPrice)
            .where('productPrice', isLessThanOrEqualTo: maxPrice)
            .orderBy('productPrice')
            .snapshots();
      } else if (sort == SortConst.newest) {
        return productCollection
            .orderBy('createdUpdatedAt', descending: true)
            .snapshots();
      } else if (sort == SortConst.latest) {
        return productCollection.orderBy('createdUpdatedAt').snapshots();
      } else {
        return productCollection.snapshots();
      }
    }
  }
}
