import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreModel {
  final String? name;
  final String? email;
  final String? id;

  FireStoreModel({required this.name, required this.email, this.id});

  factory FireStoreModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return FireStoreModel(
      name: data?["name"],
      email: data?["address"],
      id: snapshot.id,
    );
  }

  Map<String, String> toFirestore() {
    return {
      if (name != null) "name": name!,
      if (email != null) "address": email!
    };
  }
}
