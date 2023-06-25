import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/screens/News_Screen.dart';

class ContainerCategory extends StatelessWidget {
  String categorytext;
  String ImageUrl;
  ContainerCategory(
      {super.key, required this.categorytext, required this.ImageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsScreen(cat: categorytext.toLowerCase())));
        },
        child: Container(
          height: 240,
          width: 240,
          
          margin: EdgeInsets.all(15),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(ImageUrl)),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(25)),
                child: Text(
                  categorytext,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ));
  }
}
