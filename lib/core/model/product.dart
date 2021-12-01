import 'dart:convert';

ProductModel productFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    // this.productId,
    this.productName,
    this.productDescription,
    // this.productPrice,
    // this.productCategory,
    // this.productPicture,
    // this.productUserId,
    // this.createdUpdatedAt,
  });

  // String? productId;
  String? productName;
  String? productDescription;
  // String? productPrice;
  // String? productCategory;
  // String? productPicture;
  // String? productUserId;
  // String? createdUpdatedAt;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    // productId: json["productId"],
    productName: json["productName"],
    productDescription: json["productDescription"],
    // productPrice: json["productPrice"],
    // productCategory: json["productCategory"],
    // productPicture: json["productPicture"],
    // productUserId: json["productUserId"],
    // createdUpdatedAt: json["createdUpdatedAt"],
  );

  Map<String, dynamic> toJson() => {
    // "productId": productId,
    "productName": productName,
    "productDescription": productDescription,
    // "productPrice": productPrice,
    // "productCategory": productCategory,
    // "productPicture": productPicture,
    // "productUserId": productUserId,
    // "createdUpdatedAt": createdUpdatedAt,
  };
}
