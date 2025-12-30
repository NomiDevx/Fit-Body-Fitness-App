import 'package:fbfitnessapp/providers/workoutProvider.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:fbfitnessapp/widgets/appBar.dart';
import 'package:fbfitnessapp/widgets/favoriteWorkoutListtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
// ... your other imports ...

class Favouriteitemsscreen extends StatefulWidget {
  const Favouriteitemsscreen({Key? key}) : super(key: key);

  @override
  _FavouriteitemsscreenState createState() => _FavouriteitemsscreenState();
}

class _FavouriteitemsscreenState extends State<Favouriteitemsscreen> {
  int selectedIcon = -1;
  int selectedButtonIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _showFilterRow = true;
  bool _isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!_isScrollingDown) {
        _isScrollingDown = true;
        _showFilterRow = false;
        setState(() {});
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isScrollingDown) {
        _isScrollingDown = false;
        _showFilterRow = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: CustomAppBar(
        title: 'Favorites',
        selectedIndex: selectedIcon,
        onIconTap: (index) {
          setState(() {
            selectedIcon = index;
          });
        },
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: _showFilterRow ? 50 : 0,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Sort By',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 12,
                      ),
                    ),
                    _buildFilterButton('All', 0),
                    _buildFilterButton('Videos', 1),
                    _buildFilterButton('Articles', 2),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<WorkoutProvider>(
              builder: (context, work, child) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: work.workouts.length,
                  itemBuilder: (context, index) {
                    return Favoriteworkoutlisttile(
                      workout: work.workouts[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ... keep your existing _buildFilterButton method ...
  Widget _buildFilterButton(String text, int index) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedButtonIndex = index;
          });
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          backgroundColor:
              selectedButtonIndex == index
                  ? AppColors.primary
                  : Colors.grey[800],
          foregroundColor:
              selectedButtonIndex == index ? Colors.white : AppColors.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          minimumSize: Size(0, 0),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
