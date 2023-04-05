import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/full_report.dart';
import 'package:frontend/models/bar_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyReport extends StatelessWidget {
  final List<dynamic> resultList;
  final List<dynamic> wordList;
  const DailyReport(this.resultList, this.wordList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BarChartModel> _barChartList = [
      for (int i = 0; i < wordList.length; i++)BarChartModel(wordList[i]['word'],wordList[i]['count'])
    ];
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
                ],
                rows: [
                  for (int i = 0; i < wordList.length; i++)
                  DataRow(cells: [
                    DataCell(Text(wordList[i]['word'])),
                    DataCell(Text(wordList[i]['count'].toString())),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "TOTAL : ${resultList.length}",
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return FullReport(resultList,wordList);
                    }));
                  },
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
