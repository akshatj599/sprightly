
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sprightly/views/Recipe_showFullRecipe.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';

class Recipe extends StatefulWidget {
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  _RecipeState() {
    if (glb.allCategories.isEmpty) {
      isLoading = true;
      getRecipesFromFB();
    }
  }

  bool isLoading = false;
  Column mainColumn = Column();

  Future<void> getRecipesFromFB() async {
    print("Running getRecipesFromFB()");
    CollectionReference recipes =
        FirebaseFirestore.instance.collection('Recipes');
    DocumentReference docRef = recipes.doc("All categories");
    Map<String, Map<String, dynamic>> mapOfMaps;
    DocumentSnapshot doc = await docRef.get();
    List allCategories2 = doc["Categories"];
    allCategories2.forEach((collectionName) async {
      QuerySnapshot querySnapshot =
          await docRef.collection(collectionName).get();
      mapOfMaps = {};
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> map = Map();
        map['id'] = doc.id;
        map['Cook Time'] = doc['Cook Time'];
        map['Prep Time'] = doc['Prep Time'];
        map['Energy'] = doc['Energy'];
        map['URL'] = doc['URL'];
        map['Ingredients'] = doc['Ingredients'];
        map['Method'] = doc['Method'];
        mapOfMaps[doc.id] = map;
      });
      glb.allCategories[collectionName] = mapOfMaps;
      createAllCards();
    });
    setState(() {
      isLoading = false;
    });
  }

  void createAllCards() {
    List<Widget> lsOuter = [];
    List<Widget> lsInner;
    glb.allCategories.forEach((collectionName, mapOfMealMaps) {
      lsOuter.add(makeCategoryContainer(collectionName));
      lsOuter.add(SizedBox(height: 10));
      lsInner = [];
      mapOfMealMaps.forEach((doc, map) {
        lsInner.add(makeRecipeContainer(
            map["URL"], map['id'], map['Energy'], collectionName));
      });
      lsOuter.add(SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: lsInner,
        ),
      ));
      lsOuter.add(SizedBox(height: 10));
      setState(() {
        mainColumn = Column(children: lsOuter);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    createAllCards();
    return isLoading
        ? Center(
            child: Column(
                children: [SizedBox(height: 40), CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFEC407A)))]),
          )
        : SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: mainColumn,
          );
  }

  Widget makeCategoryContainer(String category) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        // boxShadow: [
        //     BoxShadow(
        //       color: Colors.black.withOpacity(0.1),
        //       // spreadRadius: 5,
        //       blurRadius: 5,
        //       offset: Offset(0, 3), // changes position of shadow
        //     ),
        //   ],
          color: glb.main_background, borderRadius: BorderRadius.circular(10)),
      child: Text(
        category,
        style: getAppTextStyle(18, glb.main_foreground_header, true),
      ),
    );
  }

  GestureDetector makeRecipeContainer(
      String url, String title, String calories, String category) {
    // title = transformString(title);
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Recipe_ShowFullRecipe(category, title))).then((value) {
          glb.bnb.onTap(glb.bnb.currentIndex);
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     // spreadRadius: 5,
          //     blurRadius: 5,
          //     offset: Offset(0, 3), // changes position of shadow
          //   ),
          // ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: glb.main_background),
        width: 150,
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
                  child: Stack(children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.3,
                        child: Image.asset(
                          'images/sprightly_icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ]),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                title + "\n\n",
                style: getAppTextStyle(16, glb.main_foreground_header, false),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                // maxLines: 3,
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
