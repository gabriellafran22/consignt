import 'package:consignt/common/navigate.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/di.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                inject<Navigate>().navigateTo(ScreenConst.searchResultScreen,
                    popPrevious: true,
                    arguments: {
                      'searchQueryController': searchController,
                    });
              },
            ),
          ),
        ),
      ),
      body: Text("Search"),
    );
  }
}
