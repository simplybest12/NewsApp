import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/screens/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsTile extends StatelessWidget {
  final author;
  final title;
  final description;
  final url;
  final urlToImage;
  final content;
 final DateTime published;

  NewsTile(
      {super.key,
      this.author,
      this.content,
      this.description,
      this.title,
      this.url,
      this.urlToImage,
      required this.published});


  
  @override
  Widget build(BuildContext context) {
    String pub = DateFormat('dd MMMM yyyy').format(published);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(12)),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.87,
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewScreen(
                            posturl: url,
                          )));
            },
            child: Stack(
              children: [
                Container(
                  height: 400,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      urlToImage,
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
                      borderRadius: BorderRadius.only(
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
                        title,
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
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                pub,
                maxLines: 1,
              )),
              Expanded(
                child: Text(
                  author,
                  // Disable wrapping of text
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Divider(),
          SizedBox(
            height: 8,
          ),
          Text(
            description,
            textAlign: TextAlign.left,
            style: GoogleFonts.lato(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
