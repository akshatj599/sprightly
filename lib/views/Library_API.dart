import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sprightly/backend/keys.dart';
import 'package:sprightly/widgets/globals.dart' as glb;
import 'package:sprightly/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class LibraryAPI extends StatefulWidget {
  final String query;
  final Image image;

  LibraryAPI(this.query, this.image);

  @override
  _LibraryAPIState createState() => _LibraryAPIState();
}

class _LibraryAPIState extends State<LibraryAPI> {
  _LibraryAPIState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getArticles();
    });
  }

  bool isLoading = true;
  Map<String, dynamic> responseBody = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: glb.main_scaffold_background,
      appBar: glb.appBar_Sprightly(() {
        setState(() {
          glb.switchTheme();
        });
      }),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(Color(0xFFEC407A))),
            )
          : Stack(
              fit: StackFit.expand,
              children: [
                Opacity(opacity: 0.3, child: widget.image),
                SafeArea(
                  child: makeCards(),
                ),
              ],
            ),
    );
  }

  Future<void> getArticles() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=" +
            widget.query +
            "&api-key=" +
            ny_api_key);
    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      responseBody = jsonDecode(response.body);
    } else {
      showSnackBar(
          "An error occured. Please try again. Error code: " +
              response.statusCode.toString(),
          context);
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget makeCards() {
    setState(() {
      isLoading = true;
    });
    List mainList = responseBody["response"]["docs"];
    List<Widget> ls = [
      Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height / 15,
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Text(
          "Top articles on " + widget.query,
          style: getAppTextStyle(16, glb.main_foreground_header, true),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: glb.main_background),
      )
    ];
    for (int i = 0; i < mainList.length; i++) {
      //A federal judge blocks Bidenâs vaccine mandate for U.S. health workers.
      //"main" -> "Democratsâ Bill Would Go Far Toward âPatching the Holesâ in Health Coverage"
      //"main" -> "Omicron: What Is Known â and Still Unknown"
      ls.add(GestureDetector(
        onTap: () {
          launch(mainList[i]["web_url"].toString());
        },
        child: Container(
          alignment: Alignment.bottomLeft,
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
          padding: EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              mainList[i]["headline"]["main"]
                  .toString()
                  .replaceAll("â", "'")
                  .replaceAll("â", "'")
                  .replaceAll("â", "-"),
              style: getAppTextStyle(16, glb.main_foreground_header, true),
            ),
            mainList[i]["byline"]["original"] != null
                ? Text(
                    mainList[i]["byline"]["original"].toString(),
                    style:
                        getAppTextStyle(14, glb.main_foreground_header, false),
                    textAlign: TextAlign.left,
                  )
                : Container(),
            Text(
              mainList[i]["pub_date"].toString().split('T')[0],
              style: getAppTextStyle(14, glb.main_foreground_header, false),
            ),
            SizedBox(
              height: 10,
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(
                Icons.touch_app,
                color: glb.main_foreground_header,
              ),
              Text(
                " Tap to read",
                style: getAppTextStyle(14, glb.main_foreground_header, false),
              ),
            ])
          ]),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: glb.main_background,
          ),
        ),
      ));
    }
    setState(() {
      isLoading = false;
    });
    return ListView(
      shrinkWrap: true,
      children: ls,
    );
  }
}
