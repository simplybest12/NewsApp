import 'package:flutter/material.dart';
import 'package:newsapp/screens/News_Screen.dart';

import 'screens/Welcome_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: 'welcome',
      routes: {
        'welcome' :(context) => const WelcomeScreen(),
        'news' : (context) => const NewsScreen()
      },
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

