import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_horizon_webos/presentation/exercises/model/exercise_model.dart';
import 'package:health_horizon_webos/services/api_services.dart';
import 'package:http/http.dart' as http;

class ExerciseProvider with ChangeNotifier {
  bool isElectedChip = false;

  List<ExerciseModel> allExercises = [];
  Future getAllExercises() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiServices.apiEndPoint}exercise/get-all"),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        allExercises =
            jsonResponse.map((item) => ExerciseModel.fromJson(item)).toList();
        notifyListeners();
      } else {
        notifyListeners();
        print("Somthing went wrong ${response.body}");
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  List<dynamic> categories = [];

  Future getAllCategories() async {
    try {
      final response = await http.get(
        Uri.parse("${ApiServices.apiEndPoint}exercise/get-categories"),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        // print(jsonResponse);
        categories = jsonResponse;
        notifyListeners();
        // categories = jsonResponse.map((item)=> item.to);

        // allExercises =
        //     jsonResponse.map((item) => ExerciseModel.fromJson(item)).toList();
        notifyListeners();
      } else {
        notifyListeners();
        print("Somthing went wrong ${response.body}");
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
