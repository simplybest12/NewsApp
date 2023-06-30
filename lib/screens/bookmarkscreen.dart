import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/newstile.dart';
import 'web_view.dart';

class BookMark extends StatefulWidget {
  BookMark({Key? key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  List<dynamic> bookList = [];
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('bookmark');

  Future<void> fetchdatagoogle() async {
    QuerySnapshot querySnapshot = await userCollection.get();
    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        bookList = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
    }
  }

  Future<void> deleteDocument(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookmark')
          .doc(documentId)
          .delete();

      setState(() {
        bookList.removeWhere((item) => item['uid'] == documentId);
      });

      print('Item deleted successfully');
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchdatagoogle();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bookmarks",
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      body: ListView.builder(
        itemCount: bookList.length,
        itemBuilder: (context, index) {
          var data = bookList[index];
          if (bookList.isEmpty) {
            return Center(child: Text("Your Bookmark is empty"));
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    child: Text(
                      data['title'],
                      maxLines: 3,
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          "Posted at: " + data['postedtime'],
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Slidable(
                    endActionPane: ActionPane(
                      dragDismissible: true,
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (BuildContext context) async {
                            await deleteDocument(data['uid']);
                            print("Item deleted: ${data['uid']}");
                          },
                          icon: Icons.delete_rounded,
                          backgroundColor: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35),
                          ),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(
                              posturl: data['url'],
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 240,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(35),
                                bottomRight: Radius.circular(35),
                              ),
                              child: Image.network(
                                data['urlToimage'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 240,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(35),
                                bottomRight: Radius.circular(35),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    data['author'],
                    style: TextStyle(color: Colors.black45),
                  ),
                  Divider(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
