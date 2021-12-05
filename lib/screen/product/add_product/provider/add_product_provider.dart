import 'package:consignt/common/async.dart';
import 'package:consignt/core/custom_change_notifier.dart';
import 'package:consignt/core/model/city.dart';
import 'package:consignt/core/model/province.dart';
import 'package:consignt/core/network/response/city_response.dart';
import 'package:consignt/core/network/response/province_response.dart';
import 'package:consignt/core/network/service/api/raja_ongkir_service.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_product_service.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';

import '../../../../di.dart';

class AddProductProvider extends CustomChangeNotifier {
  PreferencesHelper preferencesHelper;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  String _userId = '';
  String productCategory = '';
  String productProvince = '';
  String productCity = '';
  String productPictureUrl = '';
  String provinceId = '0';
  bool isChanged = false;

  AddProductProvider({required this.preferencesHelper}) {
    _getUserId();
    getProvince();
  }

  final _rajaOngkirService = inject.get<RajaOngkirService>();

  Async<List<Province>> province = uninitialized<List<Province>>();
  Async<List<City>> city = uninitialized<List<City>>();

  Future<bool> saveForm() async {
    final bool isValid = formKey.currentState!.validate();
    if (isValid &&
        productPictureUrl.isNotEmpty &&
        productCategory.isNotEmpty &&
        productProvince.isNotEmpty &&
        productCity.isNotEmpty) {
      addProduct();
      return true;
    }
    return false;
  }

  Future<void> _getUserId() async {
    final user = await preferencesHelper.userId;
    _userId = user;
    notifyListeners();
  }

  Future getProvince() async {
    customApi(
      service: _rajaOngkirService.getProvince(),
      object: province,
      execute: (ProvinceResponse response) {
        province.success(
          response.rajaongkir?.results ?? [],
        );
      },
    );
  }

  Future getCity() async {
    customApi(
      service: _rajaOngkirService.getCity(provinceId: provinceId),
      object: province,
      execute: (CityResponse response) {
        city.success(
          response.rajaongkir?.results ?? [],
        );
      },
    );
  }

  void setProductPicture(String imagePath) {
    productPictureUrl = imagePath;
    isChanged = true;
    notifyListeners();
  }

  void setProductCategory(String tempCategory) {
    productCategory = tempCategory;
    isChanged = true;
    notifyListeners();
  }

  void setProductProvince(Province tempProvince) {
    productProvince = tempProvince.province ?? '';
    provinceId = tempProvince.provinceId ?? '0';
    isChanged = true;
    getCity();
    notifyListeners();
  }

  void setProductCity(City tempCity) {
    productCity = '${tempCity.type} ${tempCity.cityName}';
    isChanged = true;
    notifyListeners();
  }

  void addProduct() {
    FirestoreProductService.addProduct(
      userId: _userId,
      productName: productNameController.text,
      productDescription: productDescController.text,
      productPrice: int.parse(productPriceController.text),
      productCategory: productCategory,
      productPictureUrl: productPictureUrl,
      productProvince: productProvince,
      productCity: productCity,
    );
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    productDescController.dispose();
    productPriceController.dispose();
  }
}
