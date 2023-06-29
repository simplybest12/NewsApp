import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider.dart';
import '../widgets/newstile.dart';

class BookMark extends StatefulWidget {
  BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  NewsTile newslist = NewsTile();
  @override
  Widget build(BuildContext context) {
    //  List<dynamic> mylist =
    //   Provider.of<DataModel>(context).myDatamodel;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Bookmarks",
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black45,
        ),
        body: ListView.builder(
          itemCount: 5,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(""),
            );
          }),
        ));
  }
}
