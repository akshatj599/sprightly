import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';

class Recipe extends StatefulWidget {
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          makeCategoryContainer("200 Calorie Meal"),
          getCategoryItemsFromFB("xyz")
        ],
      ),
    );
  }

  SingleChildScrollView getCategoryItemsFromFB(String category) {
    //TODO: Get items from FB
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          makeRecipeContainer(
              "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/fruity-milk-jellies-b975f93.jpg?webp=true&quality=90&resize=440%2C400",
              "Spiced glazed pineapple with cinnamon fromage frais",
              "159"),
          makeRecipeContainer(
              "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/fruity-milk-jellies-b975f93.jpg?webp=true&quality=90&resize=440%2C400",
              "Spiced glazed pineapple with cinnamon fromage frais",
              "159"),
          makeRecipeContainer(
              "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/fruity-milk-jellies-b975f93.jpg?webp=true&quality=90&resize=440%2C400",
              "Spiced glazed pineapple with cinnamon fromage frais",
              "159")
        ],
      ),
    );
  }

  Widget makeCategoryContainer(String category) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
          color: glb.main_background, borderRadius: BorderRadius.circular(10)),
      child: Text(
        category,
        style: getAppTextStyle(18, glb.main_foreground_header, true),
      ),
    );
  }

  Container makeRecipeContainer(String url, String title, String calories) {
    title = transformString(title);
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: glb.main_background),
      width: 150,
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 150,
              height: 125,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Positioned.fill(
                    child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                )),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              title,
              style: getAppTextStyle(16, glb.main_foreground_header, false),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              calories + " kcal",
              style: getAppTextStyle(16, glb.main_foreground_dimmer, false),
            ),
          )
        ],
      ),
    );
  }

  String transformString(String title) {
    if (title.length > 26)
      return title.substring(0, 26) + "...";
    else
      return title;
  }
}
/*
FatSecret API Platform
OAuth 1.0 Client Secret: 8928ecde72f54ba8839e1cf0fc9b9bb2
OAuth 2.0 Client Secret: 1a02caafb190401182f4f88d07949cb1
Client ID & Consumer Key: e0fbcc8cfcfd4823ad22ed2b8ac1f1ac
*/

/*
String addSlashN(String str){
  String res="";
  for(int i=0; i<str.length; i++){
    if(str[i]=="\n"){
      res+="\\n";
    }
    else{
      res+=str[i];
    }
  }
  return res;
}
*/
