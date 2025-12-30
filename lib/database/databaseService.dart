import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbfitnessapp/models/article_model.dart';
import 'package:fbfitnessapp/models/workoutModel.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all workouts
  Stream<List<Workout>> get workouts {
    return _firestore.collection('workouts')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(_workoutListFromSnapshot);
  }

  // Fetch all articles
  Stream<List<Article>> get articles {
    return _firestore.collection('articles')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(_articleListFromSnapshot);
  }

  // Fetch favorite workouts
  Stream<List<Workout>> get favoriteWorkouts {
    return _firestore.collection('workouts')
      .where('isFavorite', isEqualTo: true)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(_workoutListFromSnapshot);
  }

  // Fetch favorite articles
  Stream<List<Article>> get favoriteArticles {
    return _firestore.collection('articles')
      .where('isFavorite', isEqualTo: true)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map(_articleListFromSnapshot);
  }

  // Helper methods to convert snapshots to model objects
  List<Workout> _workoutListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Workout(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        duration: data['duration'] ?? '',
        calories: data['calories'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        videoUrl: data['videoUrl'] ?? '',
        description: data['description'] ?? '',
        exercisesCount: data['exercisesCount'] ?? 0,
        isFavorite: data['isFavorite'] ?? false,
        isVideo: data['isVideo'] ?? true,
      );
    }).toList();
  }

  List<Article> _articleListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Article(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        imageUrl: data['imageUrl'] ?? '',
        description: data['description'] ?? '',
        isFavourite: data['isFavorite'] ?? false,
        isArticle: data['isArticle'] ?? true,
      );
    }).toList();
  }
}