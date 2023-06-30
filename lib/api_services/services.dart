import 'dart:convert';
import 'dart:developer';
import 'package:newsapp/model/api_model.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class APIServices {
  List<Article> news = [];
  Future<void> getNewsData(String category) async {
    var uri = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=${Constants.APIKey}");
    try {
      var response = await http.get(uri);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("200...");
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'ok') {
          jsonData['articles'].forEach((element) {
            if (element['urlToImage'] != null &&
                element['description'] != null) {
              Article articlelist = Article(
                author: element["author"],
                title: element["title"],
                description: element["description"],
                url: element["url"],
                urlToImage: element["urlToImage"],
                publishedAt: DateTime.parse(element["publishedAt"]),
                content: element["content"],
              );
              news.add(articlelist);
            }
          });
        }
      }
    } catch (e) {
      print("Catched error");
      log(e.toString());
    }
  }
}
