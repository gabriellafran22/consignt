import 'package:consignt/core/model/search_history.dart';
import 'package:consignt/screen/search/search/search_history_database/search_history_database_helper.dart';
import 'package:flutter/cupertino.dart';

class SearchHistoryDatabaseProvider extends ChangeNotifier {
  final SearchHistoryDatabaseHelper searchHistoryDatabaseHelper;
  List<SearchHistoryModel> _allSearchHistory = [];

  SearchHistoryDatabaseProvider({required this.searchHistoryDatabaseHelper}) {
    _getSearchHistory();
  }

  List<SearchHistoryModel> get searchHistory => _allSearchHistory;

  void _getSearchHistory() async {
    _allSearchHistory = await searchHistoryDatabaseHelper.getSearchHistory();
    notifyListeners();
  }

  void addSearchHistory(SearchHistoryModel searchHistoryModel) async {
    try {
      await searchHistoryDatabaseHelper.addSearchHistory(searchHistoryModel);
      _getSearchHistory();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void deleteSearchHistoryById(int id) async {
    try {
      await searchHistoryDatabaseHelper.deleteSearchHistoryById(id);
      _getSearchHistory();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void deleteAllSearchHistory() async {
    try {
      await searchHistoryDatabaseHelper.deleteAllSearchHistory();
      _getSearchHistory();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
