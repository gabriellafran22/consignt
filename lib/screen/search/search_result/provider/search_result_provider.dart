import 'package:consignt/constant/sort_const.dart';
import 'package:flutter/cupertino.dart';

class SearchResultProvider extends ChangeNotifier {
  String _sort = SortConst.defaultValue;

  String get sort => _sort;

  void setSort(String tempSort) {
    _sort = tempSort;
    notifyListeners();
  }
}
