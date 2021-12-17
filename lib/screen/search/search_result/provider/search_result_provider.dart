import 'package:consignt/common/async.dart';
import 'package:consignt/constant/sort_const.dart';
import 'package:consignt/core/custom_change_notifier.dart';
import 'package:consignt/core/model/city.dart';
import 'package:consignt/core/network/response/city_response.dart';
import 'package:consignt/core/network/service/api/raja_ongkir_service.dart';
import 'package:flutter/cupertino.dart';

import '../../../../di.dart';

class SearchResultProvider extends CustomChangeNotifier {
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController cityTextField = TextEditingController();

  int minPrice = 0;
  int maxPrice = 999999999999999999;
  String _sort = SortConst.defaultValue;

  String get sort => _sort;

  final _rajaOngkirService = inject.get<RajaOngkirService>();
  Async<List<City>> city = uninitialized<List<City>>();

  SearchResultProvider() {
    getAllCity();
    cityTextField.text = 'City';
  }

  Future getAllCity() async {
    customApi(
      service: _rajaOngkirService.getCity(),
      object: city,
      execute: (CityResponse response) {
        city.success(
          response.rajaongkir?.results ?? [],
        );
      },
    );
  }

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

  void setCity(City tempCity) {
    cityTextField.text = '${tempCity.type} ${tempCity.cityName}';
  }

  void resetCity() {
    cityTextField.text = 'City';
  }

  void resetMinPrice() {
    minPrice = 0;
    maxPriceController.text = '';
  }

  void resetMaxPrice() {
    minPriceController.text = '';
    maxPrice = 999999999999999999;
  }

  void clearAll() {
    resetCity();
    resetMinPrice();
    resetMaxPrice();
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    cityTextField.dispose();
    cityTextField.text = 'City';
  }
}
