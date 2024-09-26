// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:myshop_admin/Model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> deleteUserDatatoFirestore(String uid) async {
    await userCollection.doc(uid).delete();
    notifyListeners();
  }

  Future<UserModel> getUserFromFirestore(String uid) async {
    final user = await userCollection.doc(uid).get();
    return UserModel.fromJson(user.data()!);
  }

  Future<List<UserModel>> fetchAllUsers() async {
    final querySnapshot = await userCollection.get();
    return querySnapshot.docs
        .map((doc) => UserModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> updateUserImage(String uid, String imageUrl) async {
    await userCollection.doc(uid).update({'profileImage': imageUrl});
    notifyListeners();
  }
}
