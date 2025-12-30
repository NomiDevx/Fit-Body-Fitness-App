import 'package:fbfitnessapp/screens/addArticleScreen.dart';
import 'package:fbfitnessapp/screens/addWorkoutScreen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // Import Syncfusion

class Admindashborad extends StatefulWidget {
  const Admindashborad({super.key});

  @override
  State<Admindashborad> createState() => _AdmindashboradState();
}

class _AdmindashboradState extends State<Admindashborad> {
  // Dummy data for chart
  final List<ChartData> _chartData = [
    ChartData('Mon', 3),
    ChartData('Tue', 4),
    ChartData('Wed', 6),
    ChartData('Thu', 5),
    ChartData('Fri', 8),
    ChartData('Sat', 6),
    ChartData('Sun', 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 20),

            /// Chart
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: SfCartesianChart(
                  backgroundColor: Colors.transparent,
                  title: ChartTitle(text: 'Weekly Activity', textStyle: TextStyle(color: Colors.white)),
                  primaryXAxis: CategoryAxis(
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  primaryYAxis: NumericAxis(
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  series: <CartesianSeries<ChartData, String>>[
                    LineSeries<ChartData, String>(
                      dataSource: _chartData,
                      xValueMapper: (ChartData data, _) => data.day,
                      yValueMapper: (ChartData data, _) => data.value,
                      color: Colors.blueAccent,
                      dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddWorkoutScreen(),
                      ),
                    );
                  },
                  child: Text('Add Workout'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddArticleScreen(),
                      ),
                    );
                  },
                  child: Text('Add Articles'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Chart data model
class ChartData {
  final String day;
  final double value;

  ChartData(this.day, this.value);
}
