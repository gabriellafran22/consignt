import 'package:consignt/core/model/product.dart';
import 'package:consignt/core/model/user.dart';

class Utils {
  static UserModel convertDocumentToUserModel(
    Map<String, dynamic> data,
  ) {
    return UserModel(
      email: data['email'],
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      province: data['province'],
      city: data['city'],
      profilePicture: data['profilePicture'],
      isSeller: data['isSeller'],
      createdUpdatedAt: data['createdUpdatedAt'],
    );
  }

  static ProductModel convertDocumentToProductModel(
      Map<String, dynamic> data,
      ) {
    return ProductModel(
      userId: data["userId"],
      productName: data["productName"],
      productDescription: data["productDescription"],
      productPrice: data["productPrice"],
      productCategory: data["productCategory"],
      productPictureUrl: data["productPictureUrl"],
      productProvince: data["productProvince"],
      productCity: data["productCity"],
      createdUpdatedAt: data["createdUpdatedAt"],
    );
  }
}
