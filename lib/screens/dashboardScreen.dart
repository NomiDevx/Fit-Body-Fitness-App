import 'package:fbfitnessapp/models/workoutModel.dart';
import 'package:fbfitnessapp/providers/article_provider.dart';
import 'package:fbfitnessapp/providers/workoutProvider.dart';
import 'package:fbfitnessapp/screens/ResoucesScreen.dart';
import 'package:fbfitnessapp/screens/adminDashborad.dart';
import 'package:fbfitnessapp/screens/profileScreen.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:fbfitnessapp/widgets/articleRecommendation.dart';
import 'package:fbfitnessapp/widgets/workoutRecommendation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  String username = 'Xnomi';
  int selectedIndex = -1; // -1 means nothing selected
  late final Workout workout;
  // final Challenges = Provider.of<WeeklyChallenges>(context).challenges;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi, $username',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AppColors.heading,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = 100; // just a test value
                          });
                        },
                        icon: const Icon(Icons.search_rounded),
                        color:
                            selectedIndex == 100
                                ? AppColors.secondary
                                : AppColors.heading,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = 101;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Admindashborad(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.notifications),
                        color:
                            selectedIndex == 101
                                ? AppColors.secondary
                                : AppColors.heading,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = 102;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  const Profilescreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.person),
                        color:
                            selectedIndex == 102
                                ? AppColors.secondary
                                : AppColors.heading,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'It\'s time to challenge your limits.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMenuItem(Icons.workspaces_outline, 'Workout', 0),
                  _verticalDivider(),
                  _buildMenuItem(Icons.checklist_rounded, 'Progress', 1),
                  _verticalDivider(),
                  _buildMenuItem(Icons.apple, 'Nutrition', 2),
                  _verticalDivider(),
                  _buildMenuItem(Icons.people_rounded, 'Community', 3),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommendation',
                    style: TextStyle(color: AppColors.secondary),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Resoucesscreen(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'See All',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_right,
                          color: AppColors.secondary,
                          size: 26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Consumer<WorkoutProvider>(
                builder: (context, workoutProvider, _) {
                  return Workoutrecommendation(workoutProvider.workouts);
                },
              ),
              SizedBox(height: 8),
              Container(
                height: 150,
                width: double.infinity,
                color: AppColors.primary,
                child: Card(
                  // decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  color: Colors.grey[900],
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Weekly\nChanllenges',
                              textAlign: TextAlign.center,
                              // softWrap: true,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColors.secondary,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'plank With Hit Twist',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox.expand(
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1-srZtQnTZyYTYpza3q_5f30lDJt2j5qYQA&s',
                              fit: BoxFit.cover,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Articles & Tips',
                    style: TextStyle(color: AppColors.secondary),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder:
                      //         (context) => Artileslayoutscreen(article: article),
                      //   ),
                      // );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'See All',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_right,
                          color: AppColors.secondary,
                          size: 26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Consumer<ArticleProvider>(
                builder: (context, articleProvider, _) {
                  return Articlerecommendation(
                    articles: articleProvider.articles,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, int index) {
    final isActive = selectedIndex == index;
    final color =
        isActive
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).primaryColor;

    return Column(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              selectedIndex = index;
            });
          },
          icon: Icon(icon, color: color),
        ),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 10, fontFamily: 'Poppins'),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 36,
      child: VerticalDivider(
        color: Theme.of(context).colorScheme.secondary,
        thickness: 1,
        width: 20,
      ),
    );
  }
}
