import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> authstateChange() => auth.authStateChanges();

  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
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
