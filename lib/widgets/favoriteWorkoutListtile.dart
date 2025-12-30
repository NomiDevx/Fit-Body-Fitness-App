import 'package:fbfitnessapp/models/workoutModel.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';

class Favoriteworkoutlisttile extends StatelessWidget {
  final Workout workout;

  const Favoriteworkoutlisttile({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 120,

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Workout details on the right
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      workout.title,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Duration and calories row
                    Row(
                      children: [
                        const Icon(Icons.access_time_filled_rounded, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          workout.duration,
                          style: const TextStyle(fontSize: 12),
                        ),

                        // const SizedBox(width: 12),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.local_fire_department, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          workout.calories,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),

                    // const SizedBox(height: 8),

                    // Exercises count
                    Row(
                      children: [
                        const Icon(Icons.explore_rounded, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '${workout.exercisesCount} exercises',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),

              // Image on the right
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      workout.imageUrl,
                      fit: BoxFit.cover,
                      width: 180,
                      height: 125,
                    ),
                  ),

                  Positioned(
                    top: 6,
                    right: 6,
                    child: Icon(
                      workout.isFavorite
                          ? Icons.star_border_outlined
                          : Icons.star,
                      color: AppColors.secondary,
                      size: 20,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(1, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
