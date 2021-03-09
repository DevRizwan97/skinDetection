import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/main.dart';
import 'package:my_cities_time/screens/Travel.dart';
import 'package:my_cities_time/screens/blog_detail.dart';
import 'package:my_cities_time/screens/location.dart';
import 'package:my_cities_time/screens/product_detail.dart';
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
                "Blog Section",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700),
              ),
            ),
            // SizedBox(height: 10,),

            // Container(
            // height: MediaQuery.of(context).size.height * 0.65 ,
            //   child: ListView.builder(
            //     itemCount: state.all_blogs==null?0:state.all_blogs.length,
            //     itemBuilder: (context, index) {
            //     return  Padding(
            //       padding: const EdgeInsets.only(left:12.0,right: 12.0,bottom: 5),
            //       child: GestureDetector(
            //         onTap: (){
            //           Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetail(
            //           blog: state.all_blogs[index],
            //           )));
            //         },
            //
            //         child: Container(
            //           height: MediaQuery.of(context).size.height * 0.18,
            //           child: Card(
            //               color: cardColor,
            //               elevation: 5,
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.only(
            //                     bottomRight: Radius.circular(15),
            //                     topRight: Radius.circular(15),
            //                     topLeft: Radius.circular(15),
            //                     bottomLeft: Radius.circular(15)),
            //               ),
            //               child: Row(
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(left:6.0,top: 6.0,bottom: 6.0),
            //                     child: ClipRRect(
            //                         borderRadius: BorderRadius.circular(15.0),
            //                         child: state.all_blogs[index].imageurl==null?(Image.asset("assets/images/photo.jpg",width: 125,)):
            //                         Image.network(state.all_blogs[index].imageurl,width: 125,))
            //                   ),
            //                   Column(
            //                     crossAxisAlignment: CrossAxisAlignment.center,
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       SizedBox(height: 10,),
            //                       Padding(
            //                         padding: const EdgeInsets.only(top:8.0,left: 8.9,right: 8.0,bottom: 5),
            //                         child: Container(
            //                           width: 150,
            //
            //                           child: Center(
            //                             child: Text(
            //                                 state.all_blogs[index].title==null?"":  state.all_blogs[index].title,
            //                                 style: TextStyle(fontSize: 14.0,fontFamily: "OpenSans",fontWeight: FontWeight.w700),
            //                                 maxLines: 4,
            //
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                       Container(
            //                         width: MediaQuery.of(context).size.width * 0.5,
            //                         child: Padding(
            //                           padding: const EdgeInsets.only(left:8.0,bottom: 8.0),
            //                           child: AutoSizeText(
            //                               state.all_blogs[index].sub_description==null?"":  state.all_blogs[index].sub_description,
            //                               style: TextStyle(fontSize: 10.0,fontFamily: "OpenSans"),
            //                               maxLines: 3
            //                           ),
            //                         ),
            //                       )
            //                     ],
            //                   )
            //                 ],
            //               )
            //           ),
            //         ),
            //       ),
            //     );
            //   }
            //
            //       ),
            // )

            //---------- new blog layout ------------\\

            // Padding(
            //   padding: EdgeInsets.only(left: 20.0,top: 20.0, bottom: 20.0,right: 20),
            //   child: Stack(
            //     children: <Widget>[
            //       Container(
            //           width: MediaQuery.of(context).size.width ,
            //           height: MediaQuery.of(context).size.width * 0.90,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(14.0),
            //               color: Colors.white,
            //               boxShadow: [BoxShadow(
            //                   color: Colors.black26,
            //                   offset: Offset(0.0,4.0),
            //                   blurRadius: 10.0,
            //                   spreadRadius: 0.10
            //               )]
            //           ),
            //           child: ClipRRect(
            //             borderRadius: BorderRadius.circular(14.0),
            //             child: Image(
            //               image: AssetImage("assets/images/photo.jpg"),
            //               fit: BoxFit.cover,
            //             ),
            //           )
            //       ),
            //       Positioned(
            //         bottom: 10.0,
            //         left: 10.0,
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Container(
            //               width: MediaQuery.of(context).size.width * 0.60,
            //               child: Text(
            //                 "blog.name",
            //                 style: TextStyle(
            //                   fontSize: 22.0,
            //                   color: Colors.white,
            //                   fontWeight: FontWeight.bold,
            //                   letterSpacing: 1.6,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(height: 10.0),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: <Widget>[
            //                 CircleAvatar(
            //                     radius: 10.0,
            //                     backgroundImage: AssetImage("assets/images/photo.jpg")
            //                 ),
            //                 SizedBox(width: 8.0),
            //                 Text(
            //                     "blog.author.name",
            //                     style: TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 14.0
            //                     )
            //                 ),
            //
            //               ],
            //             )
            //           ],
            //         ),
            //       ),
            //       Positioned(
            //         bottom: 10.0,
            //         right: 10.0,
            //         child: Row(
            //           children: <Widget>[
            //             Icon(
            //               Icons.timer,
            //               size: 10.0,
            //               color: Colors.white,
            //             ),
            //             SizedBox(width: 5.0),
            //             Text(
            //                 "blog.created_at",
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 12.0,
            //                 )
            //             )
            //           ],
            //         ),
            //       ),
            //       // Positioned(
            //       //   top: 10.0,
            //       //   right: 10.0,
            //       //   child: Icon(
            //       //       Icons.bookmark,
            //       //       size: 26.0,
            //       //       color: Colors.white
            //       //   ),
            //       // )
            //     ],
            //   ),
            // ),

            //------------------- new blog post ----------------------\\

            Padding(
              padding: EdgeInsets.only(
                  left: 20.0, top: 20.0, bottom: 20.0, right: 20),
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
                              child: new Image.asset(
                                "assets/images/photo.jpg",
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
                              child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem" ,
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
          ],
        ),
      ),
    );
  }
}
