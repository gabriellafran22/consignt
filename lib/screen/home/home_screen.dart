import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:consignt/screen/home/widget/filter_modal_bottom_sheet.dart';
import 'package:consignt/screen/home/widget/sort_modal_bottom_sheet.dart';
import 'package:consignt/widget/product_grid_card.dart';
import 'package:consignt/widget/product_list_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../di.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PreferencesProvider>(
        builder: (context, prefProvider, _) {
          return NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
                            margin: const EdgeInsets.only(
                              left: 10,
                              top: 10,
                              right: 10,
                            ),
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: TextField(
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 8),
                                  prefixIcon: Icon(Icons.search),
                                  hintText: 'Search a product',
                                  border: InputBorder.none,
                                ),
                                onTap: () {
                                  //TODO: SEARCH PRODUCT
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
                                  icon: prefProvider.isListView
                                      ? const Icon(
                                          Icons.format_list_bulleted,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.grid_view,
                                          color: Colors.white,
                                        ),
                                  onPressed: () {
                                    if (prefProvider.isListView) {
                                      prefProvider.setView(false);
                                    } else {
                                      prefProvider.setView(true);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshots) {
                if (snapshots.hasData) {
                  return prefProvider.isListView
                      ? ListView(
                          padding: EdgeInsets.zero,
                          children: productListCard(snapshots),
                        )
                      : GridView.count(
                          padding: EdgeInsets.zero,
                          crossAxisCount: 2,
                          children: productGridCard(snapshots),
                        );
                }
                return Container();
              },
            ),
          );
        },
      ),
    );
  }

// getProductItems(AsyncSnapshot<QuerySnapshot> snapshot) {
//   return snapshot.data!.docs
//       .map((doc) => InkWell(
//             onTap: () {
//               inject<Navigate>().navigateTo(ScreenConst.detailProduct);
//             },
//             child: Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Row(
//                   children: [
//                     Image.network(
//                       doc['productPictureUrl'],
//                       width: 80,
//                       height: 80,
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             doc['productName'],
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2,
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             'Rp. ${doc['productPrice']}',
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ))
//       .toList();
// }
}

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<PreferencesProvider>(
//         builder: (context, prefProvider, _) {
//           return NestedScrollView(
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return <Widget>[
//                 SliverAppBar(
//                   collapsedHeight: 100,
//                   floating: true,
//                   pinned: true,
//                   flexibleSpace: FlexibleSpaceBar(
//                     background: SafeArea(
//                       child: Column(
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(
//                               left: 10,
//                               top: 10,
//                               right: 10,
//                             ),
//                             width: double.infinity,
//                             height: 40,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: Center(
//                               child: TextField(
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.only(top: 8),
//                                   prefixIcon: Icon(Icons.search),
//                                   hintText: 'Search a product',
//                                   border: InputBorder.none,
//                                 ),
//                                 onTap: () {
//                                   //TODO: SEARCH PRODUCT
//                                 },
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: Row(
//                               children: [
//                                 const FilterModalBottomSheet(),
//                                 const SortModalBottomSheet(),
//                                 IconButton(
//                                   icon: prefProvider.isListView
//                                       ? const Icon(
//                                           Icons.format_list_bulleted,
//                                           color: Colors.white,
//                                         )
//                                       : const Icon(
//                                           Icons.grid_view,
//                                           color: Colors.white,
//                                         ),
//                                   onPressed: () {
//                                     if (prefProvider.isListView) {
//                                       prefProvider.setView(false);
//                                     } else {
//                                       prefProvider.setView(true);
//                                     }
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ];
//             },
//             body: prefProvider.isListView
//                 ? ListView(
//                     padding: EdgeInsets.zero,
//                     children: [
//                       productListCard(context),
//                       productListCard(context),
//                       productListCard(context),
//                       productListCard(context),
//                       productListCard(context),
//                       productListCard(context),
//                       productListCard(context),
//                     ],
//                   )
//                 : GridView.count(
//                     padding: EdgeInsets.zero,
//                     crossAxisCount: 2,
//                     children: [
//                       productGridCard(),
//                       productGridCard2(),
//                       productGridCard2(),
//                       productGridCard(),
//                       productGridCard(),
//                       productGridCard(),
//                     ],
//                   ),
//           );
//         },
//       ),
//     );
//   }
// }
