import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/screens/web_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class NewsTile extends StatefulWidget {
  final author;
  final title;
  final description;
  final url;
  final urlToImage;
  final content;
  final FunctionAdd;
  final FunctionDel;
  final published;

  NewsTile(
      {super.key,
      this.author,
      this.content,
      this.description,
      this.title,
      this.url,
      this.urlToImage,
      this.FunctionAdd,
      this.FunctionDel,
      this.published});

  @override
  State<NewsTile> createState() => _NewsTileState();
}

int counter = 1;
String uid = 'a';

CollectionReference userCollection =
    FirebaseFirestore.instance.collection('bookmark');
Future addBookmark(String title, String author, String urlToImage, String pub,
    String url) async {
  String documentId = userCollection.doc().id;
  // await FirebaseFirestore.instance
  //     .collection('bookmark')
  //     .add({'title': title, "description": description, 'id': documentId});
  Map<String, dynamic> data = {
    'title': title,
    'author': author,
    'uid': documentId,
    'urlToimage': urlToImage,
    'postedtime': pub,
    'url': url,
  };
  userCollection.doc(documentId).set(data);
}

class _NewsTileState extends State<NewsTile> {
  List<dynamic> chckList = [];
  bool isPressed = false;

  Widget build(BuildContext context) {
    String pub = DateFormat('dd MMMM yyyy').format(widget.published);
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.87,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  pub,
                  maxLines: 1,
                  style: GoogleFonts.lato(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                )),
                IconButton(
                    onPressed: () {
                      addBookmark(widget.title, widget.author,
                          widget.urlToImage, pub, widget.url);
                      chckList.add(uid);
                      print(uid);
                    },
                    icon: isPressed
                        ? const Icon(
                            Icons.bookmark_outline_outlined,
                            color: Colors.black,
                            size: 20,
                          )
                        : const Icon(
                            Icons.bookmark,
                            color: Colors.black,
                            size: 20,
                          )),
                IconButton(
                    onPressed: () {
                      print("Before share");
                      Share.share(
                        widget.description + "\n" + widget.url,
                      );

                      print("after");
                    },
                    icon: const Icon(
                      CupertinoIcons.share,
                      color: Colors.black,
                      size: 20,
                    ))
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewScreen(
                              posturl: widget.url,
                            )));
              },
              child: Stack(
                children: [
                  Container(
                    height: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        widget.urlToImage,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(16),
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16)),
                        color: Colors.black.withOpacity(0.6),
                      ),
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.title,
                          maxLines: 3,
                          style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                widget.author,
                // Disable wrapping of text
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
            ]),
            const SizedBox(
              height: 4,
            ),
            const Divider(),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.description,
                textAlign: TextAlign.left,
                style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
