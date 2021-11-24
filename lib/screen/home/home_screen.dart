import 'package:consignt/screen/home/widget/filter_modal_bottom_sheet.dart';
import 'package:consignt/screen/home/widget/sort_modal_bottom_sheet.dart';
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              collapsedHeight: 100,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                    child: Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, top: 10, right: 10),
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const FilterModalBottomSheet(),
                          const SortModalBottomSheet(),
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
                                ? const Icon(
                                    Icons.format_list_bulleted,
                                    color: Colors.white,
                                  )
                                : const Icon(Icons.grid_view,
                                    color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ),
            ),
          ];
        },
        body: isListView
            ? ListView(
                padding: EdgeInsets.zero,
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
                padding: EdgeInsets.zero,
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
      ),
    );
  }
}

class ItemChoice {
  final int id;
  final String label;

  ItemChoice(this.id, this.label);
}
