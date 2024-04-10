import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group1_mapd726_shoe_app/utils/preference_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:ui' as ui;

import 'app_color.dart';

class AppUtils{
  AppUtils._privateConstructor();
  static final AppUtils instance = AppUtils._privateConstructor();


  getPreferenceValueViaKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (key == PreferenceKey.prefLogin) {
      return prefs.getBool(key);
    }

    else if (key == PreferenceKey.prefUserId) {
      return prefs.getString(key);
    }
    else if (key == PreferenceKey.prefFirstName) {
      return prefs.getString(key);
    }
    else if (key == PreferenceKey.prefLastName) {
      return prefs.getString(key);
    }
    else if (key == PreferenceKey.prefUserType) {
      return prefs.getString(key);
    }
    else if (key == PreferenceKey.prefEmailId) {
      return prefs.getString(key);
    }

    else if (key == PreferenceKey.prefPhoneNumber) {
      return prefs.getString(key);
    }

  }

  addPref(String type, String key, var value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (type == "String") {
      prefs.setString(key, value);
    } else if (type == "Bool") {
      prefs.setBool(key, value);
    } else if (type == "Double") {
      prefs.setDouble(key, value);
    } else {
      prefs.setInt(key, value);
    }
  }

  void showToast(
      {String? toastMessage, Color? backgroundColor, Color? textColor}) {
    Fluttertoast.showToast(
        msg: toastMessage!,
        backgroundColor: backgroundColor ??Colors.black,
        textColor: textColor ?? Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM);
  }


  TextStyle textStyle({Color? color,double? fontSize,FontWeight? fontWeight,FontStyle? fontStyle,TextDecoration? textDecoration}){
    return TextStyle(
        color: color??AppColors.black,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: textDecoration
    );
  }

}