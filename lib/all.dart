import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled12/Login.dart';

class AppColors {
  static const Color1 = Colors.black;
  static const Color2 = Colors.white;
  static const Color3 = Colors.blue;
}

class UserDetails {
  static String? userId;
  static String? userPhone;
  static String? Name;
  static String? photo;
}

Future getUserDetails() async {
  UserDetails.userId = await LocalDataSaver.getUserId();
  UserDetails.userPhone = await LocalDataSaver.getUserPhone();
  UserDetails.Name = await LocalDataSaver.getName();
  UserDetails.photo = await LocalDataSaver.getphoto();
}

Future clearUserDetails() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
  LocalDataSaver.setUserLogin(false);
  LocalDataSaver.setUserPhone("");
  LocalDataSaver.setUserId("");
  LocalDataSaver.setphoto('');
}

class LocalDataSaver {
  static const userIDKey = "User ID Key";
  static const userPhoneKey = "Phone Key";
  static const loginKey = "Login Key";
  static const nameKey = "Name Key";
  static const photoKey = "Photo";

  static Future<bool> setUserId(String userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(userIDKey, userId);
  }

  static Future<String?> getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userIDKey);
  }

  static Future<bool> setphoto(String photo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(photoKey, photo);
  }

  static Future<String?> getphoto() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(photoKey);
  }

  static Future<bool> setName(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(nameKey, name);
  }

  static Future<String?> getName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(nameKey);
  }

  static Future<bool> setUserPhone(String userPhone) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(userPhoneKey, userPhone);
  }

  static Future<String?> getUserPhone() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userPhoneKey);
  }

  static Future<bool> setUserLogin(bool isLogin) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setBool(loginKey, isLogin);
  }

  static Future<bool?> getUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(loginKey);
  }
}


