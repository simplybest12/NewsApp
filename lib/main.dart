import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/provider.dart';
import 'package:newsapp/screens/News_Screen.dart';
import 'package:newsapp/screens/bookmarkscreen.dart';
import 'package:newsapp/screens/category_screen.dart';
import 'package:newsapp/screens/settings.dart';
import 'package:newsapp/widgets/newstile.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'screens/Welcome_Screen.dart';

void main() {
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
      initialRoute: 'category',
      routes: {
        'welcome': (context) => const WelcomeScreen(),
        'category': (context) => CategoryScreen(),
        'dark': (context) => DarkMode(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
