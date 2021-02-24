import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/screens/location.dart';
import 'package:my_cities_time/screens/the_skin_lab.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer();
    });
    super.initState();
  }

  void timer() async {
    Future.delayed(Duration(seconds: 3)).then((_) {
      var state = Provider.of<AuthState>(context, listen: false);
      // state.authStatus = AuthStatus.NOT_DETERMINED;
      state.getCurrentUser();
      state.getallSkins();
      state.getallBlogs();
    });
  }

  Widget _body() {
    var height = 150.0;
    return Container(
      height: MediaQuery.of(context).size.height,
      width:  MediaQuery.of(context).size.width,
      child: Container(
        height: height,
        width: height,
        color: Colors.white,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Platform.isIOS
            //     ? CupertinoActivityIndicator(
            //   radius: 35,
            // )
            //     : CircularProgressIndicator(
            //   strokeWidth: 2,
            // ),
            Image.asset(
              'assets/images/tlogo.png',
              height: 120,
              width: 120,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Scaffold(
      body:state.isbusy?_body(): state.user!=null?
         Location() : TheSkinLab(),
    );
  }
}