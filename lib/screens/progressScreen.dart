import 'package:flutter/material.dart';
import 'package:fbfitnessapp/widgets/appBar.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int selectedIcon = -1;

  final List<ChartData> chartData = [
    ChartData('Mon', 350),
    ChartData('Tue', 420),
    ChartData('Wed', 280),
    ChartData('Thu', 500),
    ChartData('Fri', 450),
    ChartData('Sat', 600),
    ChartData('Sun', 550),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: CustomAppBar(
        title: 'Progress',
        selectedIndex: selectedIcon,
        onIconTap: (index) {
          setState(() {
            selectedIcon = index;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekly Calories Burned',
                style: TextStyle(
                  color: AppColors.heading,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 250,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      axisLine: const AxisLine(width: 0),
                      labelStyle: const TextStyle(color: Colors.white70),
                    ),
                    primaryYAxis: NumericAxis(
                      isVisible: false,
                      minimum: 0,
                      maximum: 800,
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true, format: 'point.y kcal'),
                    series: <CartesianSeries<ChartData, String>>[
                      SplineAreaSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.secondary.withValues(alpha: 0.6),
                            AppColors.secondary.withValues(alpha: 0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderColor: AppColors.secondary,
                        borderWidth: 3,
                        markerSettings: MarkerSettings(
                          isVisible: true,
                          color: Colors.white,
                          borderColor: AppColors.secondary,
                          borderWidth: 2,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Daily Goals',
                style: TextStyle(
                  color: AppColors.heading,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildGoalRing('Steps', 65, Icons.directions_walk, Colors.blueAccent),
                  _buildGoalRing('Water', 80, Icons.water_drop, Colors.cyan),
                  _buildGoalRing('Sleep', 45, Icons.nights_stay, Colors.deepPurpleAccent),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Recent Achievements',
                style: TextStyle(
                  color: AppColors.heading,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildAchievementCard('7-Day Streak', 'You worked out 7 days in a row!', Icons.local_fire_department, Colors.orange),
              _buildAchievementCard('Early Bird', 'Completed 5 morning workouts.', Icons.wb_sunny, Colors.amber),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalRing(String title, double percentage, IconData icon, Color color) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SfCircularChart(
                margin: EdgeInsets.zero,
                series: <CircularSeries>[
                  RadialBarSeries<ChartData, String>(
                    dataSource: [ChartData('Goal', percentage)],
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    maximumValue: 100,
                    radius: '100%',
                    innerRadius: '75%',
                    trackColor: Colors.white12,
                    cornerStyle: CornerStyle.bothCurve,
                    pointColorMapper: (_, __) => color,
                  )
                ],
              ),
              Icon(icon, color: Colors.white70, size: 28),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
        ),
        Text(
          '${percentage.toInt()}%',
          style: TextStyle(
            color: color,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(String title, String subtitle, IconData icon, Color color) {
    return Card(
      color: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white70,
            fontFamily: 'Poppins',
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

