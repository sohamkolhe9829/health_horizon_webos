import 'package:flutter/material.dart';
import 'package:health_horizon_webos/constants/colors.dart';
import 'package:health_horizon_webos/presentation/chat/view/chat_screen.dart';
import 'package:health_horizon_webos/presentation/exercises/view/exercise_screen.dart';
import 'package:health_horizon_webos/presentation/home/view/home_screen.dart';
import 'package:health_horizon_webos/presentation/videos/view/video_screen.dart';

// ignore: must_be_immutable
class SidePanel extends StatelessWidget {
  int selectedIndex;
  SidePanel({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome back....",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Soham Kolhe\n",
              style: TextStyle(
                color: ConstantColor.blueColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            ListTile(
              tileColor: selectedIndex == 0
                  ? ConstantColor.backgroundColorDark
                  : ConstantColor.backgroundColor,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeScreen(),
                    ),
                    (_) => false);
              },
              leading: Icon(
                selectedIndex == 0 ? Icons.home : Icons.home_outlined,
                size: 35,
              ),
              title: const Text("Home "),
            ),
            heightSpace(10),
            ListTile(
              tileColor: selectedIndex == 1
                  ? ConstantColor.backgroundColorDark
                  : ConstantColor.backgroundColor,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(),
                    ),
                    (_) => false);
              },
              leading: SizedBox(
                height: 30,
                child: Image.asset(selectedIndex == 1
                    ? 'assets/icon/ai_chat_filled.png'
                    : 'assets/icon/ai_chat_outline.png'),
              ),
              title: const Text("Chat With AI"),
            ),
            heightSpace(10),
            ListTile(
              tileColor: selectedIndex == 2
                  ? ConstantColor.backgroundColorDark
                  : ConstantColor.backgroundColor,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoScreen(),
                    ),
                    (_) => false);
              },
              leading: SizedBox(
                height: 30,
                child: Image.asset(selectedIndex == 1
                    ? 'assets/icon/video_outline.png'
                    : 'assets/icon/video_filled.png'),
              ),
              title: const Text("Videos "),
            ),
            heightSpace(10),
            ListTile(
              tileColor: selectedIndex == 3
                  ? ConstantColor.backgroundColorDark
                  : ConstantColor.backgroundColor,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExerciseScreen(),
                    ),
                    (_) => false);
              },
              leading: Icon(
                selectedIndex == 3
                    ? Icons.fitness_center_outlined
                    : Icons.fitness_center,
                size: 35,
              ),
              title: const Text("Exercises "),
            ),
            heightSpace(10),
            ListTile(
              tileColor: selectedIndex == 4
                  ? ConstantColor.backgroundColorDark
                  : ConstantColor.backgroundColor,
              onTap: () {
                // CustomNavigator().pushReplacement(context, DashboardScreen());
              },
              leading: Icon(
                selectedIndex == 4 ? Icons.food_bank : Icons.food_bank_outlined,
                size: 35,
              ),
              title: const Text("Meal Planner "),
            ),
          ],
        ),
      ),
    );
  }

  heightSpace(double space) {
    return SizedBox(height: space);
  }
}
