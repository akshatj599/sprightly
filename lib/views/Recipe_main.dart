import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Recipe extends StatefulWidget {
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    getRecipesUsingAPI();
    return SingleChildScrollView(
      child: Column(
        children: [Text("Testing")],
      ),
    );
  }

  Future getRecipesUsingAPI() async {
    final url = Uri.parse(
        "https://platform.fatsecret.com/rest/server.api?method=recipe_types.get&format=json");
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/xml',
          'Authorization':
              'e0fbcc8cfcfd4823ad22ed2b8ac1f1ac 1a02caafb190401182f4f88d07949cb1'
        },
        body: jsonEncode(<String, String>{}));
    print(response.statusCode);
    print(response.body);
    print(response);
  }
}
/*
FatSecret API Platform
OAuth 1.0 Client Secret: 8928ecde72f54ba8839e1cf0fc9b9bb2
OAuth 2.0 Client Secret: 1a02caafb190401182f4f88d07949cb1
Client ID & Consumer Key: e0fbcc8cfcfd4823ad22ed2b8ac1f1ac
*/
