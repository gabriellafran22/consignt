import 'dart:convert';

ProductModel userFromJson(String str) => ProductModel.fromJson(json.decode(str));

String userToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel{
  ProductModel({
    required this.userId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productCategory,
    required this.productPictureUrl,
    required this.productProvince,
    required this.productCity,
    required this.createdUpdatedAt,
  });

  String userId;
  String productName;
  String productDescription;
  int productPrice;
  String productCategory;
  String productPictureUrl;
  String productProvince;
  String productCity;
  String createdUpdatedAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    userId: json["userId"],
    productName: json["productName"],
    productDescription: json["productDescription"],
    productPrice: json["productPrice"],
    productCategory: json["productCategory"],
    productPictureUrl: json["productPictureUrl"],
    productProvince: json["productProvince"],
    productCity: json["productCity"],
    createdUpdatedAt: json["createdUpdatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "productName": productName,
    "productDescription": productDescription,
    "productPrice": productPrice,
    "productCategory": productCategory,
    "productPictureUrl": productPictureUrl,
    "productProvince": productProvince,
    "productCity": productCity,
    "createdUpdatedAt": createdUpdatedAt,
  };
}
