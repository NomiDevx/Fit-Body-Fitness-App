import 'package:fbfitnessapp/providers/article_provider.dart';
import 'package:fbfitnessapp/providers/workoutProvider.dart';
import 'package:fbfitnessapp/screens/articleslayoutScreen.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:fbfitnessapp/widgets/workoutVideos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Resoucesscreen extends StatefulWidget {
  final int initialFilterIndex;

  const Resoucesscreen({Key? key, this.initialFilterIndex = 0}) : super(key: key);

  @override
  State<Resoucesscreen> createState() => _ResoucesscreenState();
}

class _ResoucesscreenState extends State<Resoucesscreen> {
  int selectedIndex = -1;

  late int filterIndex;

  @override
  void initState() {
    super.initState();
    filterIndex = widget.initialFilterIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        toolbarHeight: 110,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                        icon: const Icon(Icons.arrow_left),
                        color: AppColors.secondary,
                      ),
                      Text(
                        'Resources',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AppColors.heading,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedIndex = 100;
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

              // 🔽 Filter Buttons Row
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        filterIndex = 0;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          filterIndex == 0 ? AppColors.secondary : Colors.white,
                      foregroundColor:
                          filterIndex == 0 ? Colors.black : AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text('Workout Videos'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        filterIndex = 1;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          filterIndex == 1 ? AppColors.secondary : Colors.white,
                      foregroundColor:
                          filterIndex == 1 ? Colors.black : AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: const Text('Articles & Tips'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              filterIndex == 0
                  ? Consumer<WorkoutProvider>(
                    builder: (context, workoutProvider, _) {
                      return Workoutvideos(workout: workoutProvider.workouts);
                    },
                  )
                  : Consumer<ArticleProvider>(
                    builder: (context, articleProvider, _) {
                      return ArticlesLayoutScreen(
                        articles: articleProvider.articles,
                      );
                    },
                  ),
              // Add filter-specific content here
            ],
          ),
        ),
      ),
    );
  }
}
