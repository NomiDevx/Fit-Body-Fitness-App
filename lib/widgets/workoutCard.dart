import 'package:fbfitnessapp/models/workoutModel.dart';
import 'package:fbfitnessapp/screens/resourcesDetailScreen.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fbfitnessapp/providers/workoutProvider.dart'; // Import your provider

class Workoutcard extends StatelessWidget {
  final Workout workout;
  const Workoutcard({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the provider
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Resourcesdetailscreen(workoutId: workout.id),
          ),
        );
      },
      child: Container(
        width: 180,
        height: 240,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white70),
          color: Colors.black45,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 160,
              width: 240,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    child: Image.network(
                      workout.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.error_outline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        // Call the toggleFavorite method from provider
                        workoutProvider.toggleFavorite(workout.id);
                      },
                      child: Icon(
                        workout.isFavorite ? Icons.star : Icons.star_border,
                        color: AppColors.secondary,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                workout.title,
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.timer, color: AppColors.heading, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      workout.duration,
                      style: TextStyle(
                        color: AppColors.heading,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.local_fire_department,
                    color: AppColors.heading,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    workout.calories,
                    style: TextStyle(
                      color: AppColors.heading,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}