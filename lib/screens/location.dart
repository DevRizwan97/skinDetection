
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cities_time/utils/constants.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 40, right: 8),
              child: Text(
                "Location",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "Sydney",
                style: TextStyle(
                    color: fontOrange,
                    fontSize: 32,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.24,
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
                          child: Padding(
                            padding: const EdgeInsets.only(top:20.0,left: 30,bottom: 20,right: 20),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "UV Index : ",
                                          style: TextStyle(
                                              color: fontOrange,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
                                        Text("10",style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        Text(
                                          "Temprature : ",
                                          style: TextStyle(
                                              color: fontOrange,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
                                        Text("20 'C",style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        Text(
                                          "Weather : ",
                                          style: TextStyle(
                                              color: fontOrange,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
                                        Text("Sunny",style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        Text(
                                          "Peak UVI Time : ",
                                          style: TextStyle(
                                              color: fontOrange,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
                                        Text("2:10 PM",style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),),
                                      ],
                                    ),

                                  ],
                                ),
                                Spacer(),
                                Image.asset(
                                  'assets/images/sun.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.24,
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
                          child: Padding(
                            padding: const EdgeInsets.only(top:20.0,left: 30,bottom: 20,right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "👨  Your Skin Type : ",
                                      style: TextStyle(
                                          color: fontOrange,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Text("no. 6",style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text(
                                      "💪  Time To Sunburn : ",
                                      style: TextStyle(
                                          color: fontOrange,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                    ),
                                    Text("< 26 mins",style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17),),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text(
                                      "⏰  SPF : ",
                                      style: TextStyle(
                                          color: fontOrange,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                    ),
                                    Text("< 26 mins",style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17),),
                                  ],
                                ),



                              ],
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 12.0, bottom: 5,top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("NOTE : ",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w700),),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Container(
                              height: 10.0,
                              width: 10.0,
                              decoration: new BoxDecoration(
                                color: fontOrange,
                                shape: BoxShape.circle,
                              ),),
                            SizedBox(width: 10,),
                            Text("Reapply Every 2 Hours",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w400),),

                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: fontOrange,
                              height: 10,
                              thickness: 1.5,
                            )),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Container(
                              height: 10.0,
                              width: 10.0,
                              decoration: new BoxDecoration(
                                color: fontOrange,
                                shape: BoxShape.circle,
                              ),),
                            SizedBox(width: 10,),
                            Text("Choose Broad Spectrum Sunscream",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w400),),

                          ],
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: fontOrange,
                              height: 10,
                              thickness: 1.5,
                            )),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Container(
                              height: 10.0,
                              width: 10.0,
                              decoration: new BoxDecoration(
                                color: fontOrange,
                                shape: BoxShape.circle,
                              ),),
                            SizedBox(width: 10,),
                            Text("Choose Broad Spectrum Sunscream",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w400),),

                          ],
                        ),

                        SizedBox(height: 15,),
                        Row(
                          children: [
                            Text("Risk For Skin Cancer",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w700,color: fontOrange,fontSize: 20,),),
                            SizedBox(width: 10,),
                            Text(": Medium",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w700,color: Colors.black,fontSize: 20,),),


                          ],
                        ),



                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:12.0,bottom: 12.0,right: 40,left: 40),
                    child: Container(
                      height: 50,
                      width: 70,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                        ),
                        onPressed: () {},
                        color: fontOrange,
                        textColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.alarm),
                            SizedBox(width: 10,),
                            Text("Set Up Your UV Alarm",
                                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,fontFamily: "Poppins")),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
