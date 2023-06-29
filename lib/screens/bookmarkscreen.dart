import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/newstile.dart';
import 'web_view.dart';

class BookMark extends StatefulWidget {
  BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  NewsTile newslist = NewsTile();

  List<dynamic> bookList = [];
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('bookmark');

  Future fetchdatagoogle() async {
    QuerySnapshot querySnapshot = await userCollection.get();
    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        bookList = querySnapshot.docs.map((doc) => doc.data()).toList();
      });
    }
    print(bookList);
  }

  void deleteDocument(String documentId) async {
    print(documentId);
    print(userCollection.doc(documentId));
    print("Deleted");
  }

  // void deletefromList(index) {
  //   bookList.removeAt(index);
  //   setState(() {

  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchdatagoogle();
    
  }

  Widget build(BuildContext context) {
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
          itemCount: bookList.length,
          itemBuilder: ((context, index) {
            // DocumentSnapshot document = bookList[index];
            // String documentId = document.id;
            // Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            var data = bookList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Text(
                      data['title'],
                      maxLines: 3,
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
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
                  SizedBox(
                    height: 4,
                  ),
                  Slidable(
                    endActionPane: ActionPane(
                        dragDismissible: true,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (BuildContext context) async {
                              deleteDocument(data['id']);
                            },
                            icon: (Icons.delete_rounded),
                            backgroundColor: Colors.red,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(35),
                                bottomRight: Radius.circular(35)),
                          )
                        ]),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebViewScreen(
                                      posturl: data['url'],
                                    )));
                      },
                      child: Stack(
                        children: [
                          Container(
                              height: 240,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(35),
                                      bottomRight: Radius.circular(35)),
                                  child: Image.network(
                                    data['urlToimage'],
                                    fit: BoxFit.fill,
                                  ))),
                          Container(
                              height: 240,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(35),
                                    bottomRight: Radius.circular(35)),
                              )),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    data['author'],
                    style: TextStyle(color: Colors.black45),
                  ),
                  Divider(),
                ],
              ),
            );
          }),
        ));
  }
}
