import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/utils.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_product_service.dart';
import 'package:consignt/screen/product/provider/contact_provider.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return ChangeNotifierProvider(
      create: (_) => ContactProvider(),
      child: Scaffold(
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
            stream: FirestoreProductService.getProductDataWithIdStream(
              widget.productId,
            ),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              }
              return productDetail(context, snapshot.data);
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          child: Consumer<ContactProvider>(
            builder: (context, provider, _) {
              if (provider.userId == '') {
                provider.getContact(widget.productId);
              }
              return ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          provider.phoneNumber != ''
                              ? ListTile(
                                  leading: const Icon(Icons.phone),
                                  title: const Text('Phone Number'),
                                  onTap: () async {
                                    _makePhoneCall(provider.phoneNumber);
                                  },
                                )
                              : const SizedBox(),
                          provider.whatsappNumber != ''
                              ? ListTile(
                                  leading:
                                      const FaIcon(FontAwesomeIcons.whatsapp),
                                  title: const Text('Whats App'),
                                  onTap: () {
                                    _launchInBrowser(
                                      'https://api.whatsapp.com/send?phone=62${provider.whatsappNumber}',
                                    );
                                  },
                                )
                              : const SizedBox(),
                          provider.telegramUsername != ''
                              ? ListTile(
                                  leading:
                                      const FaIcon(FontAwesomeIcons.telegram),
                                  title: const Text('Telegram'),
                                  onTap: () {
                                    _launchInBrowser(
                                      'https://t.me/${provider.telegramUsername}',
                                    );
                                  },
                                )
                              : const SizedBox(),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Contact Seller'),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget productDetail(BuildContext context, DocumentSnapshot? snapshot) {
  Map<String, dynamic> data = snapshot?.data() as Map<String, dynamic>;
  var product = Utils.convertDocumentToProductModel(data);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        color: Colors.black,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: Center(
          child: product.productPictureUrl == ''
              ? Image.asset('assets/consignt_logo_cropped')
              : Image.network(product.productPictureUrl),
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
                  formatPrice(product.productPrice),
                  style: titleText20,
                ),
                const Icon(Icons.favorite_border),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              product.productName,
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
                '${product.productProvince}, ${product.productCity}',
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
                product.productCategory,
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
              product.productDescription,
              style: contentText18,
            ),
          ],
        ),
      ),
    ],
  );
}

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launch(launchUri.toString());
}

Future<void> _launchInBrowser(String url) async {
  if (!await launch(
    url,
    forceSafariVC: false,
    forceWebView: false,
    headers: <String, String>{'my_header_key': 'my_header_value'},
  )) {
    throw 'Could not launch $url';
  }
}
