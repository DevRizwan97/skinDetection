import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/page/main_screens/the_skin_lab.dart';
import 'package:my_cities_time/page/main_screens/weather_screen.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:my_cities_time/utils/helper.dart';
import 'package:provider/provider.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Splash.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController email = TextEditingController(),
      password = TextEditingController();
  bool loader = false, emailchecking = true, passwordchecking = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 3),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: double.infinity,
                      child: Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 25.0, left: 25, right: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 30),
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  controller: email,
                                  onChanged: (value) {
                                    setState(() {
                                      emailchecking =
                                          EmailValidator.validate(email.text);
                                    });
                                  },
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey.shade600),
                                    contentPadding: const EdgeInsets.only(
                                        left: 20.0, bottom: 7.0, top: 7.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              if (emailchecking == false)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 25, right: 25),
                                  child: Text(
                                    "Email is not valid",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 15,
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Password",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, right: 30),
                                child: TextField(
                                  obscureText: true,
                                  controller: password,
                                  onChanged: (value) {
                                    if (password.text.length < 8) {
                                      setState(() {
                                        passwordchecking = false;
                                      });
                                    } else {
                                      setState(() {
                                        passwordchecking = true;
                                      });
                                    }
                                  },
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        fontFamily: "OpenSans",
                                        color: Colors.grey.shade600),
                                    contentPadding: const EdgeInsets.only(
                                        left: 20.0, bottom: 7.0, top: 7.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TheSkinLab(),
                                              ));
                                        },
                                        child: Text(
                                          "Create an account",
                                          style: TextStyle(
                                              color: fontOrange,
                                              fontFamily: "OpenSans",
                                              fontSize: 15),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0,
                                        bottom: 12.0,
                                        right: 40,
                                        left: 40),
                                    child: loader
                                        ? SpinKitRipple(
                                            color: fontOrange,
                                            size: 40,
                                          )
                                        : RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(9.0),
                                            ),
                                            onPressed: () {
                                              if (email.text != null &&
                                                  password.text != null) {
                                                setState(() {
                                                  loader = true;
                                                });
                                                state
                                                    .signIn(email.text,
                                                        password.text)
                                                    .then((status) {
                                                  if (state.user != null) {
                                                    setState(() {
                                                      loader = false;
                                                    });
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SplashPage()),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
                                                  } else {
                                                    setState(() {
                                                      loader = false;
                                                    });
                                                    showsnackbartop(
                                                        "Signin Error",
                                                        "There is no user record corresponding to this identifier. The user may have been deleted.",
                                                        4,
                                                        Colors.red,
                                                        Colors.red,
                                                        Colors.red,
                                                        _scaffoldKey
                                                            .currentContext);
                                                  }
                                                });
                                                // setState(() {
                                                //   loader = false;
                                                // });
                                              }
                                            },
                                            color: fontOrange,
                                            textColor: Colors.white,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 30.0,
                                                  left: 30.0,
                                                  bottom: 10,
                                                  top: 10),
                                              child: Text("Sign in",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "OpenSans")),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Or",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sign in With",
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: fontOrange,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () {},
                              //       child: Image.asset(
                              //         'assets/images/one.PNG',
                              //         fit: BoxFit.cover,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 50,
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {},
                              //       child: Image.asset(
                              //         'assets/images/two.PNG',
                              //         fit: BoxFit.cover,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
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
