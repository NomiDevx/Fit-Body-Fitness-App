import 'package:flutter/material.dart';
import '../models/weekly_challenge.dart';
class WeeklyChallenges with ChangeNotifier {
  List<WeeklyChallenge> _challenges = [
    WeeklyChallenge(
      id: '1',
      title: '7-Day Cardio Blast',
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b',
      description: 'Complete 30 minutes of cardio every day for a week',
      points: 100,
    ),
    WeeklyChallenge(
      id: '2',
      title: 'Plank Challenge',
      imageUrl: 'https://images.unsplash.com/photo-1571019614243-c4cd4efd082b',
      description: 'Increase your plank time daily',
      points: 75,
    ),
    WeeklyChallenge(
      id: '3',
      title: '10K Steps Daily',
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b',
      description: 'Walk 10,000 steps every day this week',
      points: 90,
    ),
    WeeklyChallenge(
      id: '4',
      title: 'Yoga Week',
      imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b',
      description: 'Complete one yoga session daily',
      points: 80,
    ),
    WeeklyChallenge(
      id: '5',
      title: 'No Sugar Challenge',
      imageUrl: 'https://images.unsplash.com/photo-1490645935967-10de6ba17061',
      description: 'Avoid added sugars for 7 days',
      points: 120,
    ),
  ];

  List<WeeklyChallenge> get challenges {
    return [..._challenges];
  }

  WeeklyChallenge findById(String id) {
    return _challenges.firstWhere((challenge) => challenge.id == id);
  }

  // Add more methods as needed for your app
}