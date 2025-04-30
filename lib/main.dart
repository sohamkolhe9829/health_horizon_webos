import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:health_horizon_webos/constants/colors.dart';
import 'package:health_horizon_webos/constants/providers.dart';
import 'package:health_horizon_webos/firebase_options.dart';
import 'package:health_horizon_webos/presentation/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  Gemini.init(apiKey: 'AIzaSyAOYxZOLUG7Mb4KXC-QqMoib_8tFrnr9RU');
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    print("True");
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyD8aH6CaS6O3Hx1YMuJWwnVFu5qiv2gGV0",
        authDomain: "health-horizon-5577.firebaseapp.com",
        databaseURL: "https://health-horizon-5577-default-rtdb.firebaseio.com",
        projectId: "health-horizon-5577",
        storageBucket: "health-horizon-5577.appspot.com",
        messagingSenderId: "1064312758567",
        appId: "1:1064312758567:web:518846f108f08128988902",
      ),
    );
  } else if (Platform.isMacOS) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.macos);
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    MultiProvider(
      providers: multiProviders,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Horizon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: ConstantColor.backgroundColor,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
