import 'package:chat_app/model/fire_store_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {
  static final converter =
      FirebaseFirestore.instance.collection("users").withConverter(
            fromFirestore: FireStoreModel.fromFirestore,
            toFirestore: (FireStoreModel value, options) => value.toFirestore(),
          );

  static Future<DocumentReference<FireStoreModel>> createContact(
      FireStoreModel users) {
    return converter.add(users);
  }

  static Future<QuerySnapshot<FireStoreModel>> readContact() {
    return converter.get();
  }
}
