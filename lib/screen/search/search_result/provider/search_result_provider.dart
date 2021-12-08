import 'package:consignt/constant/sort_const.dart';
import 'package:flutter/cupertino.dart';

class SearchResultProvider extends ChangeNotifier {
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  int minPrice = 0;
  int maxPrice = 999999999999999999;
  String _sort = SortConst.defaultValue;

  String get sort => _sort;

  void setSort(String tempSort) {
    _sort = tempSort;
    notifyListeners();
  }

  void setPrice() {
    minPrice = int.parse(
        minPriceController.text.isEmpty ? '0' : minPriceController.text);
    maxPrice = int.parse(maxPriceController.text.isEmpty
        ? '999999999999999999'
        : maxPriceController.text);
    notifyListeners();
  }
}
