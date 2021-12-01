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

import '../../../di.dart';

class AddEditProductProvider extends CustomChangeNotifier {
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

  AddEditProductProvider({required this.preferencesHelper}) {
    _getUserId();
    getProvince();
  }

  final _rajaOngkirService = inject.get<RajaOngkirService>();

  Async<List<Province>> province = uninitialized<List<Province>>();
  Async<List<City>> city = uninitialized<List<City>>();

  Future<void> _getUserId() async {
    final user = await preferencesHelper.user;
    _userId = user!.id!;
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
    notifyListeners();
  }

  void setProductCategory(String tempCategory) {
    productCategory = tempCategory;
    notifyListeners();
  }

  void setProductProvince(Province tempProvince) {
    productProvince = tempProvince.province ?? '';
    provinceId = tempProvince.provinceId ?? '0';
    getCity();
    notifyListeners();
  }

  void setProductCity(City tempCity) {
    productCity = '${tempCity.type} ${tempCity.cityName}';
    notifyListeners();
  }

  void addOrUpdateProduct() {
    //TODO: PICTURE BELUM, product id blm nemu carane auto generate/increment (udah bisa edit & add)
    FirestoreProductService.createOrUpdateProduct(
        productId: 'D3NMcZTUw3hfw9Z2lFv8',
        userId: _userId,
        productName: productNameController.text,
        productDescription: productDescController.text,
        productPrice: productPriceController.text,
        productCategory: productCategory,
        productPicture: productPictureUrl,
        productProvince: productProvince,
        productCity: productCity
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