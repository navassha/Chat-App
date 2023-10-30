import 'package:chat_app/model/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = FutureProvider<AuthServices>((ref) {
  return AuthServices();
});

final authstatechangeProvider = StreamProvider<User?>((ref) {
  return AuthServices().authstateChange();
});
