import 'package:consignt/core/model/user.dart';

class Utils {
  static UserModel convertDocumentToUserModel(
    Map<String, dynamic> data,
    String? id,
  ) {
    return UserModel(
      id: id,
      name: data['name'],
      phoneNumber: data['phoneNumber'],
      province: data['province'],
      city: data['city'],
      profilePicture: data['profilePicture'],
      isSeller: data['isSeller'],
      createdUpdatedAt: data['createdUpdatedAt'],
    );
  }
}
