import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../models/workoutModel.dart';
import '../widgets/workoutCard.dart';

class Workoutvideos extends StatelessWidget {
  final List<Workout> workout;

  const Workoutvideos({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick & Easy Workout Videos',
            style: TextStyle(
              color: AppColors.secondary,
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4), // Reduced spacing
          Text(
            'Discover Fresh Workouts: Elevate Your Training',
            style: TextStyle(
              color: Colors.white70,
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12), // Reduced spacing

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: workout.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12, // Reduced spacing
                crossAxisSpacing: 3, // Further reduced horizontal spacing
              childAspectRatio: 0.68, // Slightly reduced height (increased aspect ratio)
            ),
            itemBuilder: (context, index) {
              return Workoutcard(workout: workout[index]);
            },
          ),
        ],
      ),
    );
  }
}
