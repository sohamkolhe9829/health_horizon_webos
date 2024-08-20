import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:health_horizon_webos/constants/colors.dart';
import 'package:health_horizon_webos/constants/constants.dart';
import 'package:health_horizon_webos/presentation/home/view/home_screen.dart';
import 'package:health_horizon_webos/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.saveCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Auhentication",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  "Transform your fitness journey with Health Horizon. Track workouts, count calories, and achieve your goals. Enjoy personalized plans, expert guidance, and a supportive community. From yoga to weightlifting, find workouts you love. Your path to a healthier, happier you starts here.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Text(
                "Enter this code in mobile app to connect....",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: authProvider.loginCodes.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    // int number = Random().nextInt(999999);

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: ConstantColor.secondaryColor,
                      ),
                      child: Center(
                        child: Text(
                          authProvider.loginCodes[index],
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Bounceable(
                onTap: () {
                  // authProvider.saveCode();
                  // authProvider.removeCode();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
