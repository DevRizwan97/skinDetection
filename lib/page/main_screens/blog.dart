import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/main.dart';
import 'package:my_cities_time/page/main_screens/Travel.dart';
import 'package:my_cities_time/page/main_screens/location.dart';
import 'package:my_cities_time/page/main_screens/product_detail.dart';
import 'package:my_cities_time/page/main_screens/the_protection_shop.dart';
import 'package:my_cities_time/page/main_screens/the_skin_lab.dart';
import 'package:my_cities_time/page/webview.dart';
import 'package:my_cities_time/widgets/DrawerWidget.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/themes.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:provider/provider.dart';

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      drawer: state.user != null ? DrawerWidget() : null,
      body: Container(
        width: double.infinity,
        // height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bggg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 150, left: 30, right: 8),
              child: Text(
                "News",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700),
              ),
            ),
            // SizedBox(height: 10,),

            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(top:15.0,left:0,right: 0,bottom: 0),
                itemCount: state.all_blogs==null?0:state.all_blogs.length,
                itemBuilder: (context, index) {
                return     GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewExample(url: state.all_blogs[index].link,),
                        ));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, top: 2, bottom: 10.0, right: 20),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width * 0.35,
                          child: Card(
                            color: cardColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(15)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        bottomLeft: Radius.circular(15)),
                                    child: new Image.network(
                                      state.all_blogs[index].imageurl,

                                      height:
                                      MediaQuery.of(context).size.width * 0.35,
                                      width: MediaQuery.of(context).size.width * 0.33,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(state.all_blogs[index].title ,
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 13.0,fontFamily: "OpenSans",fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

                  ),
            )




          ],
        ),
      ),
    );
  }
}
