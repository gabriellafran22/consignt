import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/async.dart';
import 'package:consignt/common/utils.dart';
import 'package:consignt/core/custom_change_notifier.dart';
import 'package:consignt/core/model/city.dart';
import 'package:consignt/core/model/product.dart';
import 'package:consignt/core/model/province.dart';
import 'package:consignt/core/network/response/city_response.dart';
import 'package:consignt/core/network/response/province_response.dart';
import 'package:consignt/core/network/service/api/raja_ongkir_service.dart';
import 'package:consignt/core/network/service/firebase/firestore/firestore_product_service.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

class EditProductProvider extends CustomChangeNotifier {
  PreferencesHelper preferencesHelper;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  String _userId = '';
  String productId = '';
  String productCategory = '';
  String productProvince = '';
  String productCity = '';
  String productPictureUrl = '';
  String provinceId = '0';
  bool isChanged = false;

  EditProductProvider({required this.preferencesHelper, required this.productId}) {
    _getProductData(productId);
    getProvince();
  }

  Future<bool> saveForm() async {
    final bool isValid = formKey.currentState!.validate();
    if (isValid &&
        productPictureUrl.isNotEmpty &&
        productCategory.isNotEmpty &&
        productProvince.isNotEmpty &&
        productCity.isNotEmpty) {
      editProduct();
      return true;
    }
    return false;
  }

  final _rajaOngkirService = inject.get<RajaOngkirService>();

  Async<List<Province>> province = uninitialized<List<Province>>();
  Async<List<City>> city = uninitialized<List<City>>();

  Future<void> _getProductData(String tempProductId) async {
    final user = await preferencesHelper.user;
    _userId = user!.id!;

    DocumentSnapshot? productSnapshot =
    await  FirestoreProductService.getProductDataWithIdForEdit(tempProductId);

    Map<String, dynamic> productData =
    productSnapshot.data() as Map<String, dynamic>;

    ProductModel productModel =
    Utils.convertDocumentToProductModel(productData);

    productId = tempProductId;
    productPictureUrl = productModel.productPictureUrl;
    productNameController.text = productModel.productName;
    productDescController.text = productModel.productDescription;
    productPriceController.text = productModel.productPrice.toString();
    productCategory = productModel.productCategory;
    productProvince = productModel.productProvince;
    productCity = productModel.productCity;

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

  void isChangedTrue(){
    isChanged = true;
    notifyListeners();
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

  void editProduct() {
    FirestoreProductService.updateProduct(
      productId: productId,
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
