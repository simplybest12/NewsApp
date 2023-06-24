import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/india_gate(1).jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "News from around the\n world for you",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          const Divider(),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Best time to read,take your time to read\na little more of this world",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
                textStyle: const TextStyle(
              fontSize: 15,
              color: Colors.black45,
            )),
          ),
          const SizedBox(
            height: 45,
          ),
          Expanded(
            child: Container(
              width: 200,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'news');
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: Colors.orange),
                  child: const Text(
                    "Get Started    >",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 1.5),
                  )),
            ),
          )
        ],
      ),
    );
  }
}