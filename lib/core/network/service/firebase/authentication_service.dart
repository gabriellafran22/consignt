import 'package:consignt/core/network/service/firebase/firestore/firestore_user_service.dart';
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

      FirestoreUserService.createOrUpdateUser(
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

  static Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      return user;
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

  static Future<void> updateEmail(
      String newEmail, String currentEmail, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: currentEmail, password: password);
      User? user = userCredential.user;
      user!.updateEmail(newEmail);
    } catch (error) {
      print(error.toString());
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
}
