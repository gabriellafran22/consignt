import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/constant/sort_const.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_search_service.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:consignt/screen/search/search_result/provider/search_result_provider.dart';
import 'package:consignt/screen/search/search_result/widget/bottom_sheet/filter_modal_bottom_sheet.dart';
import 'package:consignt/screen/search/search_result/widget/bottom_sheet/sort_modal_bottom_sheet.dart';
import 'package:consignt/screen/search/search_result/widget/grid_product/grid_search_result.dart';
import 'package:consignt/screen/search/search_result/widget/list_product/list_search_result.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:consignt/widget/price_format.dart';
import 'package:consignt/widget/warning_message.dart';
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
          return Consumer<SearchResultProvider>(
            builder: (context, provider, _) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      collapsedHeight: 110,
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                      top: 10,
                                      right: 10,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: TextField(
                                        controller:
                                            widget.searchQueryController,
                                        decoration: const InputDecoration(
                                          contentPadding:
                                              EdgeInsets.only(top: 8),
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
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: FilterModalBottomSheet(
                                      provider: provider,
                                    ),
                                  ),
                                  IconButton(
                                    padding: const EdgeInsets.only(top: 10),
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
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SortModalBottomSheet(
                                        provider: provider,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      provider.cityTextField.text == 'City'
                                          ? Container()
                                          : Chip(
                                              backgroundColor: Colors.white,
                                              label: Text(
                                                provider.cityTextField.text,
                                              ),
                                              onDeleted: () {
                                                provider.resetCity();
                                              },
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      provider.minPrice == 0
                                          ? Container()
                                          : Chip(
                                              backgroundColor: Colors.white,
                                              label: Text(
                                                  'Min Price: ${formatPrice(
                                                provider.minPrice,
                                              )}'),
                                              onDeleted: () {
                                                provider.resetMinPrice();
                                              },
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      provider.maxPrice == 999999999999999999
                                          ? Container()
                                          : SizedBox(
                                              height: 40,
                                              child: Chip(
                                                padding: EdgeInsets.zero,
                                                backgroundColor: Colors.white,
                                                label: Text(
                                                    'Max Price: ${formatPrice(
                                                  provider.maxPrice,
                                                )}'),
                                                onDeleted: () {
                                                  provider.resetMaxPrice();
                                                },
                                              ),
                                            ),
                                    ],
                                  ),
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
                  stream: FirestoreSearchService.getAllProductsWithQueryOrSort(
                    sort: provider.sort == SortConst.defaultValue
                        ? ''
                        : provider.sort,
                    minPrice: provider.minPrice,
                    maxPrice: provider.maxPrice,
                  ),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return loadingIndicator();
                    } else {
                      if (snapshot.data!.docs.isEmpty) {
                        return noProductsFound();
                      }
                      return prefProvider.isListView
                          ? listSearchResult(snapshot,
                              widget.searchQueryController.text, context)
                          : gridSearchResult(snapshot,
                              widget.searchQueryController.text, context);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
