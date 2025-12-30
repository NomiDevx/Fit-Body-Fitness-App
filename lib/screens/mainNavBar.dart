import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:flutter/material.dart';
import './dashboardScreen.dart';
import 'ResoucesScreen.dart';
import './favouriteItemScreen.dart';
import 'HelpFaqScreen.dart';

class Mainnavbar extends StatefulWidget {
  int _currentScreen = 0;
  final List<Widget> _screen = [
    Dashboardscreen(),
    Resoucesscreen(),
    Favouriteitemsscreen(),
    HelpFaqScreen(),
  ];

  @override
  State<Mainnavbar> createState() => _MainnavbarState();
}

class _MainnavbarState extends State<Mainnavbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: AppColors.primary,
        buttonBackgroundColor: AppColors.secondary,
        height: 50,
        animationDuration: const Duration(milliseconds: 300),
        index: widget._currentScreen,
        onTap: (index) {
          setState(() {
            widget._currentScreen = index;
          });
        },
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.article_rounded, size: 30, color: Colors.white),
          Icon(Icons.star, size: 30, color: Colors.white),
          Icon(Icons.headset_mic_outlined, size: 30, color: Colors.white),
        ],
      ),
      body: widget._screen[widget._currentScreen],
    );
  }
}
