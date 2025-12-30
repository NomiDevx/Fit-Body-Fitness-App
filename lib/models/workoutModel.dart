class Workout {
  final String id;
  final String title;
  final String duration;
  final String calories;
  final String imageUrl;
  final String videoUrl;
  final String description;
  final int exercisesCount;
  bool isVideo;
  bool isFavorite;

  Workout({
    required this.id,
    required this.title,
    required this.duration,
    required this.calories,
    required this.imageUrl,
    required this.videoUrl,
    required this.description,
    required this.exercisesCount,
    this.isVideo = true,
    this.isFavorite = false,
  });
}
