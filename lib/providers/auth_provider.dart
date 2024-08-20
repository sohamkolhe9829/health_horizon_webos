import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';

class AuthProvider with ChangeNotifier {
  List<String> loginCodes = [];

  saveCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('loginCode') == null) {
      int randomeNumber = Random().nextInt(900000) + 100000;
      String randomeCode = randomeNumber.toString();

      pref.setString('loginCode', randomeCode);

      print(splitString(randomeCode));

      loginCodes = splitString(randomeCode);
      print(loginCodes);
      notifyListeners();
    } else {
      loginCodes = splitString(pref.getString('loginCode')!);
      notifyListeners();
    }
  }

  removeCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('loginCode');
  }
}
