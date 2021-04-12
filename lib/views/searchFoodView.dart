import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sprightly/widgets/widgets.dart';


class SearchFoodView extends StatefulWidget {

  String mealType;

  SearchFoodView(this.mealType);

  @override
  _SearchFoodViewState createState() => _SearchFoodViewState();
}

class _SearchFoodViewState extends State<SearchFoodView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.orange[400],
            title: Image.asset('images/sprightly_logo.png', height: 40),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Center(
                    child: Text("Add A "+widget.mealType+" Item",
                  style: getAppTextStyle(20, Colors.grey[800], true)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.orange[100],
                        border: InputBorder.none,
                        hintText: 'Search an item'
                      )
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
