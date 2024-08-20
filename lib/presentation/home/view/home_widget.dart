import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_horizon_webos/constants/colors.dart';
import 'package:health_horizon_webos/presentation/home/controller/home_provider.dart';
import 'package:health_horizon_webos/widgets/bar_chart_widget.dart';
import 'package:health_horizon_webos/widgets/custom_loading.dart';
import 'package:health_horizon_webos/widgets/health_data_card.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.initialize();
    for (var i = 0; i < 2; i++) {
      homeProvider.getQuote();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset(
                'assets/img/layer_bg.svg',
                fit: BoxFit.cover,
                color: HexColor("#686868"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HealthDataCard(
                      fileName: 'heart_rate.png',
                      title: "Heart Rate",
                      value: "25 / BPM",
                    ),
                    SizedBox(height: 100),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: HealthDataCard(
                            fileName: 'cal_burn_icon.png',
                            title: "Calories Burned",
                            value: "1240 Cal",
                          ),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 5),
                      ],
                    ),
                    SizedBox(height: 100),
                    HealthDataCard(
                      fileName: 'blood_oxygen_icon.png',
                      title: "Blood Oxygen",
                      value: "30%",
                    ),
                  ],
                ),
                SvgPicture.asset(
                    'assets/illuistrations/girl_illuistrations.svg'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HealthDataCard(
                      fileName: 'heart_rate.png',
                      title: "Heart Rate",
                      value: "25 / BPM",
                    ),
                    SizedBox(height: 100),
                    Row(
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width / 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: HealthDataCard(
                            fileName: 'cal_burn_icon.png',
                            title: "Calories Burned",
                            value: "1240 Cal",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100),
                    HealthDataCard(
                      fileName: 'blood_oxygen_icon.png',
                      title: "Blood Oxygen",
                      value: "30%",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Bounceable(
                  onTap: () {
                    if (provider.stopwatch.isRunning) {
                      provider.stop();
                    } else {
                      provider.reset();
                      provider.start();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    decoration: BoxDecoration(
                      color: ConstantColor.secondaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          offset: Offset(7, 7),
                          blurRadius: 10,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: HealthDataCard(
                      fileName: 'workout_icon.png',
                      title: "Start Workout",
                      value: provider.formattedTime,
                    ),
                  ),
                ),
                Bounceable(
                  onTap: () {
                    // provider.startTimer(Duration());
                    showBottomSheet(
                        backgroundColor: ConstantColor.secondaryColor,
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 400,
                            child: Column(
                              children: [
                                CupertinoTimerPicker(
                                  initialTimerDuration: provider.timerValue,
                                  onTimerDurationChanged: (value) {
                                    provider.setTimerValue(value);
                                  },
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Bounceable(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 40),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all()),
                                        child: Center(child: Text("Close")),
                                      ),
                                    ),
                                    Bounceable(
                                      onTap: () {
                                        if (provider.timerTimer.isActive) {
                                          provider.stopTimer();
                                          Navigator.pop(context);
                                        } else {
                                          provider
                                              .startTimer(provider.timerValue);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 40),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all()),
                                        child: Center(
                                            child: Text(
                                                provider.timerTimer.isActive
                                                    ? "Stop"
                                                    : "Start")),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    decoration: BoxDecoration(
                      color: ConstantColor.secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          offset: Offset(7, 7),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: HealthDataCard(
                      fileName: 'stopwatch_icon.png',
                      title: "Timer",
                      value: provider.formattedTimerTime,
                    ),
                  ),
                ),
                Bounceable(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    decoration: BoxDecoration(
                      color: ConstantColor.secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          offset: Offset(7, 7),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: HealthDataCard(
                      fileName: 'refresh_icon.png',
                      title: "Refresh Data",
                      value: "12:00 AM | 15-05-2024",
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              "\t\t\t\tDaily Progress....",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BarChartWidget(title: "Steps"),
                BarChartWidget(title: "Calories Burned"),
                BarChartWidget(title: "Body Fat"),
              ],
            ),
            SizedBox(height: 40),
            Text(
              "\t\t\t\tDaily Quotes....",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                provider.quotes.isEmpty
                    ? CustomCircularLoading()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          " “${provider.quotes[0]}” ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
                provider.quotes.length == 1 || provider.quotes.isEmpty
                    ? CustomCircularLoading()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          " “${provider.quotes[1]}” ",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
