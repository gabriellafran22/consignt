import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_product_service.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailProductScreen extends StatefulWidget {
  final String productId;

  const DetailProductScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search a product',
                border: InputBorder.none,
              ),
              onTap: () {
                //TODO: PINDAH KE SEARCH PAGE
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream:
              FirestoreProductService.getProductDataWithId(widget.productId),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            }
            return productDetail(context, snapshot.data);
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Phone Number'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.whatsapp),
                      title: const Text('Whats App'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.telegram),
                      title: const Text('Telegram'),
                      onTap: () {},
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Contact Seller'),
        ),
      ),
    );
  }
}

dynamic productDetail(BuildContext context, DocumentSnapshot? data) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        color: Colors.black,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: Center(
          child: data?["productPictureUrl"] == null
              ? Image.asset('assets/consignt_logo_cropped')
              : Image.network(data?["productPictureUrl"]),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatPrice(data?["productPrice"]),
                  style: titleText20,
                ),
                const Icon(Icons.favorite_border),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              data?["productName"] ?? 'Product Name Not Set',
              style: contentText18,
            ),
          ],
        ),
      ),
      const Divider(
        height: 5,
        thickness: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_sharp,
              size: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                '${data?['productProvince']}, ${data?['productCity']}',
                style: contentText18,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          children: [
            const Icon(
              Icons.category_rounded,
              size: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                '${data?['productCategory']}',
                style: contentText18,
              ),
            ),
          ],
        ),
      ),
      const Divider(
        height: 15,
        thickness: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: titleText20,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              data?["productDescription"] ?? 'Product Description Not Set',
              style: contentText18,
            ),
          ],
        ),
      ),
    ],
  );
}
