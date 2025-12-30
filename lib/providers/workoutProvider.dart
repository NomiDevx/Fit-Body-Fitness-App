import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/workoutModel.dart';

class WorkoutProvider with ChangeNotifier {
  final List<Workout> _workouts = [
    Workout(
      id: 'w1',
      title: 'Squat Challenge',
      duration: '12 Minutes',
      calories: '120 Kcal',
      imageUrl:
          'https://images.unsplash.com/photo-1534258936925-c58bed479fcb?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4', // Squat demo video
      description:
          'Build lower body strength with this intense squat variation workout. Includes sumo squats, jump squats, and pistol squats to target all leg muscles.',
      exercisesCount: 8,
      isFavorite: true,
       isVideo: true,
    ),
    Workout(
      id: 'w2',
      title: 'Full Body Stretching',
      duration: '12 Minutes',
      calories: '120 Kcal',
      imageUrl:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4', // Stretching routine
      description:
          'Improve flexibility and reduce muscle tension with this complete stretching routine. Perfect for post-workout recovery or rest days.',
      exercisesCount: 10,
      isFavorite: false,
       isVideo: true,
    ),
    Workout(
      id: 'w3',
      title: 'Yoga Flow',
      duration: '15 Minutes',
      calories: '90 Kcal',
      imageUrl:
          'https://images.unsplash.com/photo-1545205597-3d9d02c29597?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4', // Yoga session
      description:
          'A calming vinyasa flow sequence to enhance mobility, balance, and mental clarity. Suitable for all levels with modifications available.',
      exercisesCount: 12,
      isFavorite: true,
       isVideo: true,
    ),
    Workout(
      id: 'w4',
      title: 'Core Strength',
      duration: '10 Minutes',
      calories: '100 Kcal',
      imageUrl:
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4', // Core workout
      description:
          'Target all abdominal muscles with this efficient core circuit. Includes planks, leg raises, and rotational movements for 360° core development.',
      exercisesCount: 6,
      isFavorite: false,
      isVideo: true,
    ),
    Workout(
      id: 'w5',
      title: 'HIIT Cardio Blast',
      duration: '20 Minutes',
      calories: '200 Kcal',
      imageUrl:
          'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4', // HIIT workout
      description:
          'High-intensity interval training designed to maximize fat burning and cardiovascular endurance. Short bursts of maximum effort followed by active recovery.',
      exercisesCount: 15,
      isFavorite: true,
       isVideo: true,
    ),
    Workout(
      id: 'w6',
      title: 'Upper Body Sculpt',
      duration: '18 Minutes',
      calories: '150 Kcal',
      imageUrl:
          'https://images.unsplash.com/photo-1637651684506-07e16fcf7b06?q=80&w=1387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4', // Upper body workout
      description:
          'Dumbbell-free routine to tone arms, shoulders, and back using bodyweight resistance. Perfect for when you can\'t get to the gym.',
      exercisesCount: 9,
      isFavorite: false,
       isVideo: true,
    ),
  ];

  List<Workout> get workouts => [..._workouts];

  void toggleFavorite(String id) async {
    final index = _workouts.indexWhere((workout) => workout.id == id);
    if (index != -1) {
      _workouts[index].isFavorite = !_workouts[index].isFavorite;
      notifyListeners();

      // Store the updated favorite value to Firestore
      // Import Firebase dependencies at the top of your file:
      // import 'package:cloud_firestore/cloud_firestore.dart';

      try {
        await FirebaseFirestore.instance
            .collection('workouts')
            .doc(_workouts[index].id)
            .update({'isFavorite': _workouts[index].isFavorite});
      } catch (e) {
        // Optionally handle errors, e.g., revert the change or show a message
        print('Failed to update favorite status: $e');
      }
    }
  }
}