// import 'package:fbfitnessapp/screens/chatAssitScreen.dart';
import 'package:fbfitnessapp/firebase_options.dart';
import 'package:fbfitnessapp/screens/adminDashborad.dart';
import 'package:fbfitnessapp/screens/dashboardScreen.dart';
import 'package:fbfitnessapp/screens/loginScreen.dart';
import 'package:fbfitnessapp/screens/signUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fbfitnessapp/providers/workoutProvider.dart';
import 'package:fbfitnessapp/providers/weeklyChallenges.dart';
import 'package:fbfitnessapp/providers/article_provider.dart';
import 'package:fbfitnessapp/theme/colors.dart';
import 'package:fbfitnessapp/screens/mainNavBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => WeeklyChallenges()),
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FB Fitness App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: AppColors.secondary,
            side: BorderSide.none,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: AppColors.secondary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.heading,
          ),
          bodyMedium: const TextStyle(fontSize: 16),
        ),
      ),

      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return Mainnavbar();
            // return Admindashborad();
          } else {
            return Loginscreen();
          }
        },
      ),
      routes: {'/login': (context) => Loginscreen()},
    );
  }
}
