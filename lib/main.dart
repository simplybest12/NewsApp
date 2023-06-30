
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/provider.dart';

import 'package:newsapp/screens/category_screen.dart';
import 'package:newsapp/screens/settings.dart';

import 'package:provider/provider.dart';

import 'screens/Welcome_Screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: 'splash',
      routes: {
        'splash' : (context) => SplashScreen(),
        'welcome': (context) => const WelcomeScreen(),
        'category': (context) => CategoryScreen(),
        'dark': (context) => DarkMode(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
