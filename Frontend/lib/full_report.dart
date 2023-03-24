import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/bar_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FullReport extends StatelessWidget {
  FullReport({Key? key}) : super(key: key);

  final List<BarChartModel> _barChartList = [
    BarChartModel('Monday', 2),
    BarChartModel('Tuesday', 4),
    BarChartModel('Wednesday', 2),
    BarChartModel('Thursday', 5),
    BarChartModel('Friday', 10),
    BarChartModel('Saturday', 15),
    BarChartModel('Sunday', 3),
  ];

  @override
  Widget build(BuildContext context) {
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
                          fontStyle: FontStyle.italic
                        ),
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
                            fontStyle: FontStyle.italic
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "34.4 Words",
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
                        dataSource: _barChartList,
                        xValueMapper: (BarChartModel sales, _) => sales.time,
                        yValueMapper: (BarChartModel sales, _) => sales.noOfWords,
                        color: Colors.blue,
                        yAxisName: "Words"
                      ),
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
                          fontStyle: FontStyle.italic
                        ),
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
                      series: <CircularSeries<BarChartModel, String>>[
                        DoughnutSeries<BarChartModel, String>(
                          dataSource: <BarChartModel>[
                            BarChartModel("Mommy", 38),
                            BarChartModel("Daddy", 36),
                            BarChartModel("Other", 25),
                          ],
                          xValueMapper: (BarChartModel sales, _) => sales.time,
                          yValueMapper: (BarChartModel sales, _) => sales.noOfWords,
                          enableTooltip: true,
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
                  onPressed: () {},
                  child: Text(
                    "More",
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
