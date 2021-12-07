import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/core/model/search_history.dart';
import 'package:consignt/di.dart';
import 'package:consignt/screen/search/search/search_history_database/search_history_database_provider.dart';
import 'package:consignt/widget/warning_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchHistoryDatabaseProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Container(
              margin: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(top: 8),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      onPressed: () {
                        searchController.clear();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                    hintText: 'Search a product',
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      provider.addSearchHistory(
                        SearchHistoryModel(searchQuery: value),
                      );
                    }
                    inject<Navigate>().navigateTo(
                      ScreenConst.searchResultScreen,
                      popPrevious: true,
                      arguments: {
                        'searchQueryController': searchController,
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          body: provider.searchHistory.isEmpty
              ? searchProductMessage()
              : _searchHistory(provider, searchController),
        );
      },
    );
  }
}

Widget _searchHistory(SearchHistoryDatabaseProvider provider,
    TextEditingController searchController) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: provider.searchHistory.length,
    itemBuilder: (context, index) {
      return Column(
        children: [
          ListTile(
            title: Text(provider.searchHistory[index].searchQuery),
            trailing: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                provider.deleteSearchHistoryById(provider.searchHistory[index].id!);
              },
            ),
            onTap: () {
              searchController.text = provider.searchHistory[index].searchQuery;
              inject<Navigate>().navigateTo(
                ScreenConst.searchResultScreen,
                popPrevious: true,
                arguments: {
                  'searchQueryController': searchController,
                },
              );
            },
          ),
          const Divider(
            height: 0,
            thickness: 2,
          ),
        ],
      );
    },
  );
}
