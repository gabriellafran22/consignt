import 'package:flutter/material.dart';

Widget productGridCard() {
  return InkWell(
    onTap: (){},
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10),
            ),
            child: Image.asset('assets/consignt_logo.jpg',),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Product Name'),
                const Text('Product Price'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text('Product Seller Location'),
                    ),
                    Icon(Icons.favorite_border),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

///ini cuman buat test kalau ukuran gambar yang di input beda
Widget productGridCard2() {
  return InkWell(
    onTap: (){},
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10),
              ),
              child: Image.asset('assets/consignt_logo_cropped.jpg',),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Product Name'),
                const Text('Product Price'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text('Product Seller Location'),
                    ),
                    Icon(Icons.favorite_border),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
