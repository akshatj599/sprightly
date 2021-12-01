import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sprightly/backend/keys.dart';

class LibraryAPI extends StatefulWidget {
  final String query;

  LibraryAPI(this.query);

  @override
  _LibraryAPIState createState() => _LibraryAPIState();
}

class _LibraryAPIState extends State<LibraryAPI> {
  _LibraryAPIState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {  getArticles(); });
    }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> getArticles() async {
    final url = Uri.parse(
        "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=" +
            widget.query +
            "&api-key=" +
            ny_api_key);
    var response = await http.get(url);
    Map<String, dynamic> map = jsonDecode(response.body);
  }
}
