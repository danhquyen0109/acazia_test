import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';

//global variable
SharedPreferences storage;

showMessage(
    {@required String message, ToastGravity gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(msg: message, gravity: gravity);
}

showLoading({BuildContext context, bool visible = true}) {
  visible
      ? showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  height: 70,
                  width: 70,
                  child: Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator(),
                ),
              ),
            );
          })
      : Container();
}

String formatName(String name) {
  List<String> words = name.split(" ").toList();
  String result = words[0][0].toUpperCase() + words[0].substring(1) + ".";
  for (int i = 1; i < words.length; i++) {
    if (i == words.length - 1) {
      result += words[i][0].toUpperCase() + words[i].substring(1);
    } else
      result += words[i][0].toUpperCase() + words[i].substring(1) + " ";
  }
  return result;
}

String formatAddress(String address) {
  List<String> words = address.split(" ").toList();
  String result = "";
  for (int i = 0; i < words.length; i++) {
    if (i == words.length - 1) {
      result += words[i][0].toUpperCase() + words[i].substring(1);
    } else
      result += words[i][0].toUpperCase() + words[i].substring(1) + " ";
  }
  return result;
}

Random random = new Random();
