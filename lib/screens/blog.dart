import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/main.dart';
import 'package:my_cities_time/screens/Travel.dart';
import 'package:my_cities_time/screens/blog_detail.dart';
import 'package:my_cities_time/screens/location.dart';
import 'package:my_cities_time/screens/the_protection_shop.dart';
import 'package:my_cities_time/screens/the_skin_lab.dart';
import 'package:my_cities_time/shared/widgets/DrawerWidget.dart';
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


      drawer:state.user!=null?DrawerWidget():null,



      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?AssetImage("assets/images/nightmode.jpg"): AssetImage("assets/images/bggg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:150,left: 30,right: 8),
              child: Text("Blog Section",style: TextStyle(
                  color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE? Colors.white : Colors.black,
                  fontSize: 32,
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700
              ),),
            ),
            SizedBox(height: 10,),


            Padding(
              padding: const EdgeInsets.only(left:12.0,right: 12.0,bottom: 5),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetail(
                    title: "Sun Protection Guidelines",
                    body: "Lorem ipsum dolor sit amet,consetetur sadipscing elitr, sed diam nonumy Lorem ipsum dolor sit amet,consetetur sadipscing elitr, sed diam nonumy Lorem ipsum dolor sit amet,consetetur sadipscing elitr, sed diam nonumy Lorem ipsum dolor sit amet,consetetur sadipscing elitr, sed diam nonumy Lorem ipsum dolor sit amet,consetetur sadipscing elitr, sed diam nonumy",
                  )));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.18,
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
                          Padding(
                            padding: const EdgeInsets.only(left:6.0,top: 6.0,bottom: 6.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.asset("assets/images/photo.jpg",width: 125,)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(top:8.0,left: 8.9,right: 8.0,bottom: 5),
                                child: AutoSizeText(
                                    'Sun Protection Guidelines',
                                    style: TextStyle(fontSize: 14.0,fontFamily: "OpenSans",fontWeight: FontWeight.w700),
                                    maxLines: 3
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
                                  child: AutoSizeText(
                                      'Lorem ipsum dolor sit amet,consetetur sadipscing elitr, sed diam nonumy',
                                      style: TextStyle(fontSize: 12.0,fontFamily: "OpenSans"),
                                      maxLines: 3
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
