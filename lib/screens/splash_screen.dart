import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _navigatetonextScreen() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, 'welcome');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetonextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/journalism.png',
          height: 200,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "We Keep You\nUpdate",
          textAlign: TextAlign.center,
          style: GoogleFonts.aBeeZee(fontSize: 35, fontWeight: FontWeight.bold),
        )
      ],
    )));
  }
}
