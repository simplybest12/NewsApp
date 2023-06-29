import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DarkMode extends StatefulWidget {
  const DarkMode({super.key});

  @override
  State<DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.5
              
            ),
            borderRadius: BorderRadius.circular(16)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text("Dark Mode",style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),),

                ),
                Expanded(
                  child: Switch(value: (true), onChanged: null,
                  activeColor: Colors.black,
                  
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}