import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

//global variable
SharedPreferences storage;

showMessage(
    {@required String message, ToastGravity gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(msg: message, gravity: gravity);
}
