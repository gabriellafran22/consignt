import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/common/url_launcher.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_product_service.dart';
import 'package:consignt/di.dart';
import 'package:consignt/screen/product/detail_product/widget/product_detail.dart';
import 'package:consignt/screen/product/provider/contact_provider.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
                readOnly: true,
                onTap: () {
                  inject<Navigate>().navigateTo(ScreenConst.searchScreen);
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
              return productDetail(context, snapshot.data, widget.productId);
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
                                  leading: const Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                  ),
                                  title: const Text('Phone Number'),
                                  onTap: () async {
                                    makePhoneCall(provider.phoneNumber);
                                  },
                                )
                              : const SizedBox(),
                          provider.whatsappNumber != ''
                              ? ListTile(
                                  leading: const FaIcon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.green,
                                  ),
                                  title: const Text('Whats App'),
                                  onTap: () {
                                    launchInBrowser(
                                      'https://api.whatsapp.com/send?phone=62${provider.whatsappNumber}',
                                    );
                                  },
                                )
                              : const SizedBox(),
                          provider.telegramUsername != ''
                              ? ListTile(
                                  leading: const FaIcon(
                                    FontAwesomeIcons.telegram,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  title: const Text('Telegram'),
                                  onTap: () {
                                    launchInBrowser(
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
                child: Text(
                  'Contact Seller',
                  style: titleTextWhite,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
