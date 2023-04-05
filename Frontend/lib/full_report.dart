import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/bar_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FullReport extends StatelessWidget {
  final List<dynamic> resultList;
  late final List<dynamic> wordList;
  final List<dynamic> barchartList;

  FullReport(this.resultList, this.wordList, this.barchartList, {Key? key})
      : super(key: key);

  List<BarChartModel> circleChart = [];

  late final TooltipBehavior _tooltipBehavior =  TooltipBehavior(enable: true);


  @override
  Widget build(BuildContext context) {
    var monday = barchartList[0];
    var tues = barchartList[1];
    var wes = barchartList[2];
    var thus = barchartList[3];
    var fri = barchartList[4];
    var sat = barchartList[5];
    var sun = barchartList[6];

    final List<BarChartModel> barChartList = [
      BarChartModel('Monday', monday),
      BarChartModel('Tuesday', tues),
      BarChartModel('Wednesday', wes),
      BarChartModel('Thursday', thus),
      BarChartModel('Friday', fri),
      BarChartModel('Saturday', sat),
      BarChartModel('Sunday', sun),
    ];

    if (wordList.length == 1) {
      circleChart = [BarChartModel(wordList[0]['word'], 100)];
    } else if (wordList.isEmpty) {
      circleChart = [BarChartModel("other", 100)];
    } else {
      double word1 = (((wordList[0]['count']) / resultList.length) * 100);
      double word2 = (((wordList[1]['count']) / resultList.length) * 100);
      print(word1);
      print(word2);
      circleChart = [
        BarChartModel(wordList[0]['word'], word1.round()),
        BarChartModel(wordList[1]['word'], word2.round()),
        BarChartModel("other", (100 - (word1 + word2)).round())
      ];
    }

    return Scaffold(
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    child: Image.asset("assets/logo.png"),
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.family_restroom,
                        color: Colors.white,
                        size: 35,
                      ),
                      Text(
                        "Mode",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                "Full Report",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Word Count",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Highest spoken word count in a day is 50.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Average",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 5),
                      Text(
                        double.parse(((monday +
                                        tues +
                                        wes +
                                        thus +
                                        fri +
                                        sat +
                                        sun) /
                                    7)
                                .toStringAsFixed(2))
                            .toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: darkblue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries<BarChartModel, String>>[
                      AreaSeries<BarChartModel, String>(
                          dataSource: barChartList,
                          xValueMapper: (BarChartModel sales, _) => sales.time,
                          yValueMapper: (BarChartModel sales, _) =>
                              sales.noOfWords,
                          color: Colors.blue,
                          yAxisName: "Words"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: darkblue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Most Spoken Words",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Total words spoken is increased by 10% than previous week's average.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SfCircularChart(
                      tooltipBehavior: _tooltipBehavior,
                      legend: Legend(isVisible: true,textStyle: TextStyle(color: Colors.white)),
                      series: <CircularSeries<BarChartModel, String>>[
                        DoughnutSeries<BarChartModel, String>(
                            dataSource: circleChart,
                            xValueMapper: (BarChartModel sales, _) => sales.time,
                            yValueMapper: (BarChartModel sales, _) => sales.noOfWords,
                            enableTooltip: true,
                            name: "Data",
                            // dataLabelSettings: DataLabelSettings(isVisible: true)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
