import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:consignt/screen/home/widget/filter_modal_bottom_sheet.dart';
import 'package:consignt/screen/home/widget/sort_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';

class SearchResultScreen extends StatefulWidget {
  final TextEditingController searchQueryController;

  const SearchResultScreen({Key? key, required this.searchQueryController})
      : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Container(
  //         margin: const EdgeInsets.only(
  //           top: 10,
  //           bottom: 10,
  //         ),
  //         width: double.infinity,
  //         height: 40,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(5),
  //         ),
  //         child: TextField(
  //             decoration: const InputDecoration(
  //               contentPadding: EdgeInsets.only(top: 8),
  //               prefixIcon: Icon(Icons.search),
  //               hintText: 'Search a product',
  //               border: InputBorder.none,
  //             ),
  //             readOnly: true,
  //             onTap: () {
  //               inject<Navigate>().navigateTo(ScreenConst.searchScreen);
  //             },
  //           ),
  //         ),
  //       ),
  //     body: Text("Search resultt"),
  //   );
  // }
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
                                controller: widget.searchQueryController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(top: 8),
                                  prefixIcon: Icon(Icons.search),
                                  hintText: 'Search a product',
                                  border: InputBorder.none,
                                ),
                                readOnly: true,
                                onTap: () {
                                  inject<Navigate>()
                                      .navigateTo(ScreenConst.searchScreen);
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
            body: Text('search result screen'),
          );
        },
      ),
    );
  }
}
