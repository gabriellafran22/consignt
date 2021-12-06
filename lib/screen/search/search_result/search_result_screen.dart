import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/constant/sort_const.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_search_service.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:consignt/screen/home/widget/filter_modal_bottom_sheet.dart';
import 'package:consignt/screen/home/widget/sort_modal_bottom_sheet.dart';
import 'package:consignt/screen/search/search_result/provider/search_result_provider.dart';
import 'package:consignt/screen/search/search_result/widget/grid_search_result.dart';
import 'package:consignt/screen/search/search_result/widget/list_search_result.dart';
import 'package:consignt/widget/loading_indicator.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PreferencesProvider>(
        builder: (context, prefProvider, _) {
          return ChangeNotifierProvider(
            create: (_) => SearchResultProvider(),
            child: Consumer<SearchResultProvider>(
              builder: (context, provider, child) {
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
                                        inject<Navigate>().navigateTo(
                                            ScreenConst.searchScreen);
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      const FilterModalBottomSheet(),
                                      SortModalBottomSheet(
                                        provider: provider,
                                      ),
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
                    stream: FirestoreSearchService.getAllProducts(
                      sort: provider.sort == SortConst.defaultValue
                          ? ''
                          : provider.sort,
                    ),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return loadingIndicator();
                      } else {
                        return prefProvider.isListView
                            ? listSearchResult(
                                snapshot, widget.searchQueryController.text)
                            : gridSearchResult(
                                snapshot, widget.searchQueryController.text);
                      }
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
