import 'package:flutter/material.dart';
import '../models/article_model.dart';

class ArticleProvider with ChangeNotifier {
  final List<Article> _articles = [
    Article(
      id: 'a1',
      title: '10 Benefits of Morning Workouts',
      imageUrl:
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      description: 'Discover how morning workouts can boost your metabolism, improve mental clarity, and set a positive tone for your entire day. Learn the science behind why exercising in the morning leads to better consistency and results.',
      isFavourite: false,
    ),
    Article(
      id: 'a2',
      title: 'Healthy Diet Tips for Gym Enthusiasts',
      imageUrl:
          'https://images.unsplash.com/photo-1490645935967-10de6ba17061?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      description: 'Nutrition is just as important as your workout routine. This guide covers the best pre- and post-workout meals, macro balancing for different fitness goals, and supplements that actually work.',
      isFavourite: true,
    ),
    Article(
      id: 'a3',
      title: 'Stretching Routines You Shouldn\'t Skip',
      imageUrl:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      description: 'Prevent injuries and improve flexibility with these essential stretching routines. Includes dynamic stretches for pre-workout and static stretches for recovery days, plus modifications for all fitness levels.',
      isFavourite: true,
    ),
    Article(
      id: 'a4',
      title: 'How to Stay Consistent with Fitness',
      imageUrl:
          'https://images.unsplash.com/photo-1550259979-ed79b48d2a30?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      description: 'Learn psychological tricks and practical strategies to maintain your fitness routine even when motivation fades. Includes habit-stacking techniques, accountability systems, and how to measure progress effectively.',
      isFavourite: true,
    ),
    Article(
      id: 'a5',
      title: 'The Science of Muscle Recovery',
      imageUrl:
          'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
      description: 'Understand what happens to your muscles after a workout and how to optimize recovery. Covers sleep importance, active recovery techniques, nutrition timing, and signs of overtraining.',
      isFavourite: false,
    ),
  ];

  List<Article> get articles => [..._articles];

  void toggleFavourite(String id) {
    final index = _articles.indexWhere((article) => article.id == id);
    if (index != -1) {
      _articles[index].isFavourite = !_articles[index].isFavourite;
      notifyListeners();
    }
  }
}