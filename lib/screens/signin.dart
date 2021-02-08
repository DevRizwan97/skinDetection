import 'package:flutter/material.dart';
import 'package:my_cities_time/screens/weather_screen.dart';
import 'package:my_cities_time/utils/constants.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bggg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 4.6),
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
                                    fontFamily: "Poppins",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 10.0, right: 30),
                                child: TextField(
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        fontFamily: "Poppins",
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

                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Password",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 10.0, right: 30),
                                child: TextField(
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        fontFamily: "Poppins",
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
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(9.0),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => WeatherScreen()));

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
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Poppins")),
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
                                        fontFamily: "Poppins",
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
                                      fontFamily: "Poppins",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Image.asset(
                                    'assets/images/one.PNG',

                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 50,),
                                  Image.asset(
                                    'assets/images/two.PNG',

                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
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
