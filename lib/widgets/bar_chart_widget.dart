import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';

final List<charts.Series<ChartData, String>> seriesList = [
  charts.Series<ChartData, String>(
    id: 'Seats',
    colorFn: (_, __) => charts.MaterialPalette.black,
    domainFn: (ChartData seatData, _) => seatData.day,
    measureFn: (ChartData seatData, _) => seatData.value,
    data: List.generate(
      dayList.length,
      (index) => ChartData('${dayList[index]}', index * 50000),
    ),
  )
];

final List dayList = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

class ChartData {
  final String day;
  final int value;

  ChartData(this.day, this.value);
}

class BarChartWidget extends StatelessWidget {
  String title;
  BarChartWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxWidth <= 992;

      return Card(
        elevation: 5,
        surfaceTintColor: Colors.transparent,
        color: Colors.white,
        child: Container(
          width: isMobile
              ? MediaQuery.of(context).size.width
              : (MediaQuery.of(context).size.width / 5),
          height: 300,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              )),
          child: Column(
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Expanded(
                child: charts.BarChart(
                  seriesList,
                  animate: true,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
