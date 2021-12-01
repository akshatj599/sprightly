import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sprightly/backend/keys.dart';

class LibraryAPI extends StatefulWidget {
  const LibraryAPI({Key key}) : super(key: key);

  @override
  _LibraryAPIState createState() => _LibraryAPIState();
}

class _LibraryAPIState extends State<LibraryAPI> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> getArticles(String query) async {
    final url = Uri.parse(
        "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=" +
            query +
            "&api-key=" +
            ny_api_key);
    var response = await http.post(url);
    if (response.statusCode == 200) {}
  }
}
