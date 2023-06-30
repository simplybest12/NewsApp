import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/api_services/services.dart';
import 'package:newsapp/screens/bookmarkscreen.dart';
import 'package:newsapp/widgets/newstile.dart';

import '../model/api_model.dart';

class NewsScreen extends StatefulWidget {
  String cat;
  NewsScreen({super.key, required this.cat});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<dynamic>> newsData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsData = fetchdata();
  }

  APIServices news = APIServices();

  Future<List<dynamic>> fetchdata() async {
    await news.getNewsData(widget.cat);
    return news.news;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BookMark()));
            },
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(14)),
              height: 40,
              child: Icon(
                Icons.bookmarks_rounded,
                color: Colors.black54,
              ),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              child: Icon(
                CupertinoIcons.square_list,
                color: Colors.black54,
              ),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'dark');
            },
            child: Container(
              height: 40,
              child: Icon(
                CupertinoIcons.settings,
                color: Colors.black54,
              ),
            ),
          ))
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
          widget.cat.toString().toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        elevation: 4,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: newsData,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              } else {
                var newsList = snapshot.data!;
                return PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: newsList.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      Article article = newsList[index];
                      return NewsTile(
                        author: article.author ?? "",
                        description: article.description ?? "",
                        urlToImage: article.urlToImage ?? "",
                        title: article.title ?? "",
                        url: article.url ?? "",
                        content: article.content ?? "",
                        published: article.publishedAt,
                      );
                    });
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: Text(
                snapshot.connectionState.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
            
          }),
    );
  }
}
