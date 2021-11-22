import 'package:consignt/screen/detail_product/detail_product_screen.dart';
import 'package:flutter/material.dart';

Widget productListCard(BuildContext context) {
  return InkWell(
    onTap: (){
      Navigator.pushNamed(context, DetailProductScreen.routeName);
    },
    child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Image.asset('assets/consignt_logo.jpg', width: 80, height: 80,),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Product Name'),
                    Text('Product Price'),
                    Text('Product Seller Location'),
                  ],
                ),
              ),
              Icon(Icons.favorite_border),
            ],
          ),
        )
    ),
  );
}