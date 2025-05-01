import 'dart:convert'; // Importing dart:convert for JSON encoding and decoding

import 'package:flutter/material.dart'; // Importing Flutter material library

import '../../model/user/user_model.dart';
import '../storage/local_storage.dart'; // Importing the user model for user data

class SessionController {
  final LocalStorage sharedPreferenceClass = LocalStorage();

  static final SessionController _session = SessionController._internal();

  static bool? isLogin;

  // static UserModel user = UserModel();

  SessionController._internal() {
    // Initialize default values
    isLogin = false;
  }


  factory SessionController() {
    return _session;
  }


  Future<void> saveUserInPreference(dynamic user) async {
    // Storing value to check login
    sharedPreferenceClass.setValue('isLogin', 'true');
  }


  Future<void> getUserFromPreference() async {
    try {
      var isLogin = await sharedPreferenceClass.readValue('isLogin');
      SessionController.isLogin = isLogin == 'true' ? true : false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
