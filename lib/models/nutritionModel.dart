class Meal {
  final String name;
  final int calories;
  final String time;
  final String imageUrl;

  Meal({
    required this.name,
    required this.calories,
    required this.time,
    required this.imageUrl,
  });
}

class DailyNutrition {
  final int targetCalories;
  final int consumedCalories;
  final int proteinGrams;
  final int carbsGrams;
  final int fatsGrams;
  final List<Meal> meals;

  DailyNutrition({
    required this.targetCalories,
    required this.consumedCalories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatsGrams,
    required this.meals,
  });
}
