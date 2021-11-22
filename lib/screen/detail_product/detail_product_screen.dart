import 'package:consignt/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailProductScreen extends StatefulWidget {
  static const routeName = '/detail_product_screen';

  const DetailProductScreen({Key? key}) : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset('assets/consignt_logo.jpg'),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Harga Produk',
                        style: titleText,
                      ),
                      Icon(Icons.favorite_border),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Nama Produk'),
                ],
              ),
            ),
            const Divider(
              height: 5,
              thickness: 10,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: titleText,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Description Produk'),
                ],
              ),
            ),
          ],
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
                      leading: Icon(Icons.phone),
                      title: Text('Phone Number'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.whatsapp),
                      title: Text('Whats App'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: FaIcon(FontAwesomeIcons.telegram),
                      title: Text('Telegram'),
                      onTap: () {},
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Contact Seller'),
        ),
      ),
    );
  }
}
