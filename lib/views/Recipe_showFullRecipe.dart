import 'package:flutter/material.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';
import 'dart:convert';

class Recipe_ShowFullRecipe extends StatefulWidget {
  String category;
  String dishName;

  Recipe_ShowFullRecipe(this.category, this.dishName);

  @override
  _Recipe_ShowFullRecipeState createState() => _Recipe_ShowFullRecipeState();
}

class _Recipe_ShowFullRecipeState extends State<Recipe_ShowFullRecipe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: glb.main_scaffold_background,
        appBar: glb.appBar_Sprightly(() {
          setState(() {
            glb.switchTheme();
          });
        }),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Image.network(
                      glb.allCategories[widget.category][widget.dishName]
                          ['URL'],
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,),
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: makeRecipeColumn(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column makeRecipeColumn(BuildContext context) {
    Map<String, dynamic> map =
        glb.allCategories[widget.category][widget.dishName];
    List<Widget> ls = [];
    ls.add(Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: glb.main_secondary),
      child: Text(map['id'], style: getAppTextStyle(18, Colors.black, true)),
    ));
    ls.add(getContainer("Energy", map['Energy'] + " kcal"));
    ls.add(getContainer("Prep Time", map['Prep Time'] + " min"));
    ls.add(getContainer("Cook Time", map['Cook Time'] + " min"));
    ls.add(Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: glb.main_background),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ingredients",
              style: getAppTextStyle(18, glb.main_foreground_header, true)),
          SizedBox(height: 10),
          Text(jsonDecode(r'{ "data":"'+map['Ingredients']+r'"}')['data'],
              style: getAppTextStyle(16, glb.main_foreground_header, false)),
        ],
      ),
    ));
    ls.add(Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: glb.main_background),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Method",
              style: getAppTextStyle(18, glb.main_foreground_header, true)),
          SizedBox(height: 10),
          Text(jsonDecode(r'{ "data":"'+map['Method']+r'"}')['data'],
              style: getAppTextStyle(16, glb.main_foreground_header, false)),
        ],
      ),
    ));
    return Column(children: ls);
  }

  Container getContainer(String str1, String str2) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: glb.main_background),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(str1,
              style: getAppTextStyle(16, glb.main_foreground_header, false)),
          Text(str2,
              style: getAppTextStyle(16, glb.main_foreground_dimmer, false))
        ],
      ),
    );
  }
}
