import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> authstateChange() => auth.authStateChanges();

  static Future<UserCredential> createUser(String email, String password) {
    return auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  static Future<UserCredential> userLogin(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signOut() {
    return auth.signOut();
  }
}
