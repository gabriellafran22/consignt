import 'package:consignt/core/network/service/firebase/firestore_service.dart';
import 'package:consignt/screen/register/provider/register_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User?> signUp({
    String email = '',
    String password = '',
    String name = '',
    String phoneNumber = '',
    String province = '',
    String city = '',
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      FirestoreService.createOrUpdateUser(
        user?.uid,
        name: name,
        phoneNumber: phoneNumber,
        province: province,
        city: city,
      );

      return user;
    } catch (error) {
      RegisterProvider.status = error.toString();
      return null;
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      return user;
    } catch (error) {
      return null;
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Stream<User?> get userStream => _auth.authStateChanges();
}
