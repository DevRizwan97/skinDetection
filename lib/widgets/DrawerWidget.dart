import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_cities_time/page/main_screens/Travel.dart';
import 'package:my_cities_time/page/main_screens/blog.dart';
import 'package:my_cities_time/page/main_screens/favourites.dart';
import 'package:my_cities_time/page/main_screens/location.dart';
import 'package:my_cities_time/page/main_screens/profile_page.dart';
import 'package:my_cities_time/page/main_screens/signin.dart';
import 'package:my_cities_time/page/main_screens/skintracker.dart';
import 'package:my_cities_time/page/main_screens/the_protection_shop.dart';
import 'package:my_cities_time/page/main_screens/the_skin_lab.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool loader = false;


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
                              boxShadow: [
                                BoxShadow(color: white, spreadRadius: 0.5)
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: state.userModel==null?AssetImage(
                                    "assets/images/profile.jpeg",
                                  ):state.userModel.imageurl==null||state.userModel.imageurl==""?AssetImage(
                                    "assets/images/profile.jpeg",
                                  ):NetworkImage( state.userModel.imageurl

                                  ))),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        state.userModel==null?"":state.userModel.username,
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
                        'Skin Lab',
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
                        'Weather',
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
                        'Explore',
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
                        'Sun Protection',
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
                        'News',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 20,
                            color: white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),  Divider(
                  color: white,
                  thickness: 0.5,
                ),

                GestureDetector(
                  onTap: () {
                    state.logoutCallback();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        SignIn()), (Route<dynamic> route) => false);

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
