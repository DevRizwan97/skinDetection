import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/main.dart';
import 'package:my_cities_time/screens/Travel.dart';
import 'package:my_cities_time/screens/location.dart';
import 'package:my_cities_time/screens/the_protection_shop.dart';
import 'package:my_cities_time/screens/the_skin_lab.dart';
import 'package:my_cities_time/shared/widgets/DrawerWidget.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/themes.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:provider/provider.dart';

class BlogDetail extends StatefulWidget {
  final String title;
  final String body;

  const BlogDetail({Key key, this.title, this.body}) : super(key: key);
  @override
  _BlogDetailState createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
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
        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:150,left: 30,right: 8),
                child: Text("Blog Detail",style: TextStyle(
                    color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE? Colors.white : Colors.black,
                    fontSize: 32,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700
                ),),
              ),
              SizedBox(height: 10,),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                      widget.title,
                                      style: TextStyle(fontSize: 20.0,fontFamily: "OpenSans",fontWeight: FontWeight.w700),

                                      overflow: TextOverflow.clip,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: AutoSizeText(
                                    widget.body,
                                    style: TextStyle(fontSize: 20.0,fontFamily: "OpenSans",fontWeight: FontWeight.w700),
                                    maxLines: 10
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 50,)
                        ],
                      ),
                    ),
                  ),
                ),
              )

//            Padding(
//              padding: const EdgeInsets.only(left:12.0,right: 12.0,bottom: 5),
//              child: Container(
//                height: MediaQuery.of(context).size.height * 0.18,
//
//                child: Card(
//                  color: cardColor,
//                    elevation: 5,
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.only(
//                          bottomRight: Radius.circular(15),
//                          topRight: Radius.circular(15),
//                          topLeft: Radius.circular(15),
//                          bottomLeft: Radius.circular(15)),
//                    ),
//                    child: Row(
//                      children: [
//                        Padding(
//                          padding: const EdgeInsets.only(left:6.0,top: 6.0,bottom: 6.0),
//                          child: ClipRRect(
//                              borderRadius: BorderRadius.circular(15.0),
//                              child: Image.asset("assets/images/photo.jpg",width: 125,)),
//                        ),
//                        Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: [
//                            SizedBox(height: 10,),
//                            Padding(
//                              padding: const EdgeInsets.only(top:8.0,left: 8.9,right: 8.0,bottom: 5),
//                              child: AutoSizeText(
//                                  'Sun Protection Guidelines',
//                                  style: TextStyle(fontSize: 14.0,fontFamily: "OpenSans",fontWeight: FontWeight.w700),
//                                  maxLines: 3
//                              ),
//                            ),
//                            Container(
//                              width: MediaQuery.of(context).size.width * 0.5,
//                              child: Padding(
//                                padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
//                                child: AutoSizeText(
//                                    'Lorem ipsum dolor sit amet,consetetur sadipscing elitr, sed diam nonumy',
//                                    style: TextStyle(fontSize: 12.0,fontFamily: "OpenSans"),
//                                    maxLines: 3
//                                ),
//                              ),
//                            )
//                          ],
//                        )
//                      ],
//                    )
//                ),
//              ),
//            ),
            ],
          ),
        ),
      ),
    );
  }
}
