import 'package:flutter/material.dart';

class HealthDataCard extends StatelessWidget {
  String fileName;
  String title;
  String value;
  HealthDataCard({
    super.key,
    required this.fileName,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
              child: Image.asset('assets/icon/$fileName'),
            ),
            Text(
              "  $title",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text("\n $value"),
      ],
    );
  }
}
