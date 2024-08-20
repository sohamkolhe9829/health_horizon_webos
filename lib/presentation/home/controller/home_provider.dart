import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {
//Init Firebase Database
  late DatabaseReference dbRef;

  List<String> quotes = [];

  initialize() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print(await getDataByChildValue('loginCode', pref.getString('loginCode')));
  }

  Future<List<dynamic>> getDataByChildValue(
      String childName, dynamic childValue) async {
    final databaseRef =
        FirebaseDatabase.instance.ref('users'); // Replace with your data path
    final query = databaseRef.orderByChild(childName).equalTo(childValue);

    final snapshot = await query.get();

    if (snapshot.exists) {
      return snapshot.children.map((child) => child.value).toList();
    } else {
      // Handle case where no data is found
      return [];
    }
  }

  getQuote() async {
    try {
      final response = await http.get(
        Uri.parse("https://api.api-ninjas.com/v1/quotes?category=fitness"),
        headers: {
          'X-Api-Key': "95y1l/VSsDZRT+wNs75K3A==RZvwKwObyFF3KTDf",
        },
      );

      if (response.statusCode == 200) {
        String quote = jsonDecode(response.body.toString())[0]['quote'];
        quotes.add(quote);
        notifyListeners();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error fetching quote: $e');
    }
  }

  //Stop Watch Codes
  Stopwatch stopwatch = Stopwatch();
  Timer? _timer;
  Duration _elapsedTime = Duration.zero;

  void start() {
    stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 100), (_) {
      _elapsedTime = stopwatch.elapsed;
      // Update UI with _elapsedTime
      notifyListeners();
    });
  }

  void stop() {
    stopwatch.stop();
    _timer?.cancel();
    notifyListeners();
  }

  void reset() {
    stopwatch.reset();
    _elapsedTime = Duration.zero;
    _timer?.cancel();
    notifyListeners();
  }

  String get formattedTime {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitHours = twoDigits(_elapsedTime.inHours.remainder(60));
    String twoDigitMinutes = twoDigits(_elapsedTime.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(_elapsedTime.inSeconds.remainder(60));

    String twoDigitMilliseconds =
        twoDigits((_elapsedTime.inMilliseconds % 1000) ~/ 10);
    return '${twoDigitHours}h :${twoDigitMinutes}m :${twoDigitSeconds}s :$twoDigitMilliseconds';
  }

//Timer Codes

  Duration timerValue = Duration();
  Duration _remainingTime = Duration.zero;
  Timer timerTimer = Timer(Duration.zero, () {});

  bool get isRunning => _timer != null;

  setTimerValue(Duration value) {
    timerValue = value;
    notifyListeners();
  }

  void startTimer(Duration duration) {
    _remainingTime = duration;
    timerTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (_remainingTime > Duration.zero) {
        _remainingTime -= Duration(seconds: 1);
        notifyListeners();
      } else {
        _timer?.cancel();
        notifyListeners();
        // Timer finished
      }
    });
  }

  void stopTimer() {
    timerTimer.cancel();
    notifyListeners();
  }

  String get formattedTimerTime {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitSeconds = twoDigits(_remainingTime.inSeconds.remainder(60));
    String twoDigitMinutes = twoDigits(_remainingTime.inMinutes.remainder(60));
    String twoDigitHours = twoDigits(_remainingTime.inHours);
    return '${twoDigitHours}h :${twoDigitMinutes}m :${twoDigitSeconds}s';
  }
}
