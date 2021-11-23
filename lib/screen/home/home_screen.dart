import 'package:consignt/widgets/product_grid_card.dart';
import 'package:consignt/widgets/product_list_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isListView = true;

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
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (isListView) {
                      isListView = false;
                    } else {
                      isListView = true;
                    }
                  });
                },
                icon: isListView
                    ? const Icon(Icons.format_list_bulleted)
                    : const Icon(Icons.grid_view))
          ],
        ),
        body: isListView
              ? ListView(
                children: [
                  productListCard(context),
                  productListCard(context),
                  productListCard(context),
                  productListCard(context),
                  productListCard(context),
                  productListCard(context),
                  productListCard(context),
                ],
              )
              : GridView.count(
                crossAxisCount: 2,
                children: [
                  productGridCard(),
                  productGridCard2(),
                  productGridCard2(),
                  productGridCard(),
                  productGridCard(),
                  productGridCard(),
                ],
              ),
    );
  }
}

