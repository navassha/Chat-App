import 'package:chat_app/model/fire_store_users.dart';
import 'package:chat_app/service/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fireStoreProvider =
    FutureProvider<QuerySnapshot<FireStoreModel>>((ref) async {
  return FireStoreServices.readContact();
});

final addUserProvider =
    FutureProvider.family<DocumentReference<FireStoreModel>, FireStoreModel>(
        (ref, fireStoreModel) async {
  return FireStoreServices.createContact(fireStoreModel);
});
