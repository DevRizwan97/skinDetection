import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_cities_time/screens/Travel.dart';
import 'package:my_cities_time/screens/blog.dart';
import 'package:my_cities_time/screens/location.dart';
import 'package:my_cities_time/screens/profile_page.dart';
import 'package:my_cities_time/screens/signin.dart';
import 'package:my_cities_time/screens/skintracker.dart';
import 'package:my_cities_time/screens/the_protection_shop.dart';
import 'package:my_cities_time/screens/the_skin_lab.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool loader = false;

  Widget _menuHeader() {
    final state = Provider.of<AuthState>(context);
    if (state.userModel == null) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 56,
              width: 56,
              margin: EdgeInsets.only(left: 17, top: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/Group.jpg",
                      ))),
            ),
            ListTile(
              onTap: () {

                // _navigateTo("ProfilePage");
              },
              title: Row(
                children: <Widget>[
                  Text(
                   state.user.displayName,
              style: TextStyle(
              fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 22.0),
                  ),
                  SizedBox(
                    width: 3,
                  ),

                ],
              ),

            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Container(
      width: 250,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
        child: Drawer(


            child: Drawer(
              child: ListView(padding: EdgeInsets.all(0.0), children: <Widget>[
//             UserAccountsDrawerHeader(
//               decoration: BoxDecoration(color: fontOrange),
//
//               currentAccountPicture: Container(
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                         fit: BoxFit.fill,
//                         image: AssetImage(
//                           "assets/images/photo.jpg",
//                         ))),
//               ),
//
// // decoration: BoxDecoration(
// //   color: fontOrange
// // ),
//
//               accountName: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     state.userModel == null ? '' : state.userModel.username,
//                     style: TextStyle(
//                         fontFamily: "OpenSans",
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black,
//                         fontSize: 22.0),
//                   ),
//                 ],
//               ),
//               arrowColor: Colors.transparent,
//
//               // currentAccountPicture: CircleAvatar(
//               //
//               //   backgroundImage: AssetImage("assets/images/img.jpeg"),
//               //   backgroundColor: Colors.transparent,
//               //   radius: 30,
//               // ),
//               onDetailsPressed: () {},
//             ),

                ListTile(
                  onTap: () {
                    // _navigateTo("ProfilePage");
                  },
                  title: Column(
mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                       onTap:(){
                         Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => ProfilePage(),
                             ));
            },
                        child: Container(
                          height: 120,
                          width: 120,
                          margin: EdgeInsets.only(left: 40, top: 60,right: 50),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: state.userModel.imageurl==null?AssetImage(
                                    "assets/images/profile.jpeg",
                                  ):NetworkImage(
                                    state.userModel.imageurl

                                  ))),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        state.userModel.username,
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 25.0),
                      ),


                    ],
                  ),

                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TheSkinLab(),
                        ));
                  },
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'The Skin Lab',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 20,
                            color: white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: white,
                  thickness: 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Location(),
                        ));
                  },
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Location',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 20,
                            color: white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: white,
                  thickness: 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Travel(),
                        ));
                  },
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Travel',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 20,
                            color: white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: white,
                  thickness: 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SkinTracker(),
                        ));
                  },
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Skin Tracker',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 20,
                            color: white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),

                Divider(
                  color: white,
                  thickness: 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TheProtectionShop(),
                        ));
                  },
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'The Protection Shop',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 20,
                            color: white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: white,
                  thickness: 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Blog(),
                        ));
                  },
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Blog Section',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 20,
                            color: white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: white,
                  thickness: 0.5,
                ),
                GestureDetector(
                  onTap: () {
                    state.logoutCallback();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ));
                  },
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 20,
                            color: white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: white,
                  thickness: 0.5,
                ),
              ]),


            ),
          ),

      ),
    );
  }

}
