import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_favorites_service.dart';
import 'package:consignt/preferences/preferences_provider.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Products',
          style: titleTextWhite,
        ),
      ),
      body: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return StreamBuilder(
            stream: FirestoreFavoriteService.allFavoriteDataBasedOnUserId(
                provider.userId),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
              if (snapshots.hasData) {
                if (snapshots.data!.docs.isEmpty) {
                  return noFavoriteProducts();
                }
                // return _myFavoritesList(snapshots);
                return Container();
              }

              return Container();
            },
          );
        },
      ),
    );
  }
}

// ListView _myFavoritesList(AsyncSnapshot<QuerySnapshot> snapshot) {
//   List<ProductModel> allProduct = [];
//   for (var item in snapshot.data!.docs) {
//     Map<String, dynamic> data = item.data() as Map<String, dynamic>;
//     ProductModel product = Utils.convertDocumentToProductModel(data);
//     allProduct.add(product);
//   }
//   return ListView.builder(
//     itemCount: allProduct.length,
//     itemBuilder: (context, index) {
//       var product = allProduct[index];
//       return InkWell(
//         onTap: () {
//           inject<Navigate>().navigateTo(
//             ScreenConst.editProduct,
//             arguments: {
//               'productId': snapshot.data!.docs[index].id,
//             },
//           );
//         },
//         child: Card(
//           elevation: 5,
//           shadowColor: Colors.blueGrey,
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Row(
//               children: [
//                 Image.network(
//                   product.productPictureUrl,
//                   width: 80,
//                   height: 80,
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         product.productName,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 2,
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         formatPrice(product.productPrice),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

