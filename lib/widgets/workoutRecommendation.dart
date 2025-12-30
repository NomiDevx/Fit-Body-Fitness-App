import 'package:fbfitnessapp/models/workoutModel.dart';
import 'package:fbfitnessapp/widgets/workoutCard.dart';
import 'package:flutter/material.dart';

class Workoutrecommendation extends StatelessWidget {
  final List<Workout> workout;

  Workoutrecommendation(this.workout);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: workout.length,
        itemBuilder: (context, index) {
          final workoutData = workout[index];
          return Workoutcard(workout: workoutData);
        },
      ),
    );
  }
}
