import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/models/bar_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyReport extends StatelessWidget {
  DailyReport({Key? key}) : super(key: key);

  final List<BarChartModel> _barChartList = [
    BarChartModel('8:00', 2),
    BarChartModel('10:00', 4),
    BarChartModel('12:00', 2),
    BarChartModel('14:00', 5),
    BarChartModel('16:00', 5),
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
                "Daily Report",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
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
                        "Distribution of Total Words by Time",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <ColumnSeries<BarChartModel, String>>[
                        ColumnSeries<BarChartModel, String>(
                          dataSource: _barChartList,
                          xValueMapper: (BarChartModel sales, _) => sales.time,
                          yValueMapper: (BarChartModel sales, _) => sales.noOfWords,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                "Detail Table,",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Spoken Words (Today)",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: DataTable(
                headingRowColor: MaterialStateProperty.resolveWith(
                    (states) => Color(0xff191717)),
                headingTextStyle: TextStyle(
                  color: Colors.white,
                ),
                columnSpacing: 20,
                dataRowColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.white,
                ),
                horizontalMargin: 10,
                border: TableBorder.all(color: Colors.black, width: 1),
                columns: [
                  DataColumn(label: Text("Word")),
                  DataColumn(label: Text("Count"), numeric: true),
                  DataColumn(label: Text("Yesterday"), numeric: true),
                  DataColumn(label: Text("Average"), numeric: true),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text("Mommy")),
                    DataCell(Text("15")),
                    DataCell(Text("15")),
                    DataCell(Text("15")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Daddy")),
                    DataCell(Text("15")),
                    DataCell(Text("15")),
                    DataCell(Text("15")),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Hungry")),
                    DataCell(Text("15")),
                    DataCell(Text("15")),
                    DataCell(Text("15")),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "TOTAL : 30",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
                    "View Full Report",
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