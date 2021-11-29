import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consignt/common/utils.dart';
import 'package:consignt/core/model/user.dart';
import 'package:consignt/core/network/service/firebase/firestore_service.dart';
import 'package:consignt/screen/login/provider/login_provider.dart';
import 'package:consignt/screen/register/provider/register_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> signUp({
    required String email,
    required String password,
    String name = '',
    String phoneNumber = '',
    String province = '',
    String city = '',
    String profilePicture = '',
    bool isSeller = false,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      FirestoreService.createOrUpdateUser(
        user?.uid,
        email: user?.email,
        name: name,
        phoneNumber: phoneNumber,
        province: province,
        city: city,
        profilePicture: profilePicture,
        isSeller: isSeller,
      );

      return user;
    } catch (error) {
      RegisterProvider.status = error.toString();
      return null;
    }
  }

  static Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      DocumentSnapshot? userSnapshot =
          await FirestoreService.getUser(user?.uid);

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      UserModel userModel =
          Utils.convertDocumentToUserModel(userData, user?.uid);

      return userModel;
    } catch (error) {
      LoginProvider.status = error.toString();
      return null;
    }
  }

  Future<bool> authenticatePassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (error) {
      return false;
    }
  }

  static Future<UserModel?> updateEmail(
      String newEmail, String currentEmail, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: currentEmail, password: password);
      User? user = userCredential.user;
      user!.updateEmail(newEmail);

      DocumentSnapshot? userSnapshot = await FirestoreService.getUser(user.uid);

      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      UserModel userModel =
          Utils.convertDocumentToUserModel(userData, user.uid);

      return userModel;
    } catch (error) {
      return null;
    }
  }

  static Future<void> updatePassword(
      String newPassword, String currentEmail, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: currentEmail, password: password);
      User? user = userCredential.user;
      user!.updatePassword(newPassword);
    } catch (error) {
      print(error.toString());
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Stream<User?> get userStream => _auth.authStateChanges();
}
