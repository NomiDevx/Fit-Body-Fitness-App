import 'package:fbfitnessapp/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final int selectedIndex;
  final Function(int) onIconTap;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBack,
    required this.selectedIndex,
    required this.onIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey[900],
      elevation: 0,
      // toolbarHeight: 80,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                      icon: const Icon(Icons.arrow_left),
                      color: AppColors.secondary,
                    ),
                    Text(
                      title,
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
                      onPressed: () => onIconTap(100),
                      icon: const Icon(Icons.search_rounded),
                      color:
                          selectedIndex == 100
                              ? AppColors.secondary
                              : AppColors.heading,
                    ),
                    IconButton(
                      onPressed: () => onIconTap(101),
                      icon: const Icon(Icons.notifications),
                      color:
                          selectedIndex == 101
                              ? AppColors.secondary
                              : AppColors.heading,
                    ),
                    IconButton(
                      onPressed: () {
                        onIconTap(102);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Profilescreen(),
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
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
