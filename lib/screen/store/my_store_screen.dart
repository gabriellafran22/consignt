import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/utils.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/core/model/product.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_product_service.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:consignt/screen/store/provider/my_store_provider.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:consignt/widget/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di.dart';

class MyStoreScreen extends StatefulWidget {
  const MyStoreScreen({Key? key}) : super(key: key);

  @override
  _MyStoreScreenState createState() => _MyStoreScreenState();
}

class _MyStoreScreenState extends State<MyStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Products',
          style: titleTextWhite,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => MyStoreProvider(
          preferencesHelper: PreferencesHelper(
            sharedPreferences: SharedPreferences.getInstance(),
          ),
        ),
        child: Consumer<MyStoreProvider>(
          builder: (context, provider, child) {
            return StreamBuilder(
              stream:
                  FirestoreProductService.getAllUsersProducts(provider.userId),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshots) {
                if (snapshots.hasData) {
                  if (snapshots.data!.docs.isEmpty) {
                    return noProductsAdded();
                  }
                  return _myProductsList(snapshots);
                }

                return Container();
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const FaIcon(FontAwesomeIcons.plus),
        onPressed: () {
          inject<Navigate>().navigateTo(ScreenConst.addProduct);
        },
      ),
    );
  }
}

ListView _myProductsList(AsyncSnapshot<QuerySnapshot> snapshot) {
  List<ProductModel> allProduct = [];
  for (var item in snapshot.data!.docs) {
    Map<String, dynamic> data = item.data() as Map<String, dynamic>;
    ProductModel product = Utils.convertDocumentToProductModel(data);
    allProduct.add(product);
  }
  return ListView.builder(
    itemCount: allProduct.length,
    itemBuilder: (context, index) {
      var product = allProduct[index];
      return InkWell(
        onTap: () {
          inject<Navigate>().navigateTo(
            ScreenConst.editProduct,
            arguments: {
              'productId': snapshot.data!.docs[index].id,
            },
          );
        },
        child: Card(
          elevation: 5,
          shadowColor: Colors.blueGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Image.network(
                  product.productPictureUrl,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        formatPrice(product.productPrice),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
