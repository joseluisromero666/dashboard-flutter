import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountService {
  static CollectionReference users = FirebaseFirestore.instance.collection('users');

  static Future<List<Map<String, String>>> getUsers() async {
    List<Map<String, String>> usersList = [];
    await users.get().then((querySnapshot) => querySnapshot.docs.forEach((doc) => usersList.add(
        {"email": doc.get("email"), "id": doc.get("id"), "name": doc.get("name"), "lastname": doc.get("lastname")})));
    return usersList;
  }
}
