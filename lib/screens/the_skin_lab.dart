import 'package:flutter/material.dart';
import 'package:my_cities_time/utils/constants.dart';

class TheSkinLab extends StatefulWidget {
  @override
  _TheSkinLabState createState() => _TheSkinLabState();
}

class _TheSkinLabState extends State<TheSkinLab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/newbg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100,left: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   "Hi, Steve",
                   style: TextStyle(
                       color: fontOrange,
                       fontSize: 20,
                       fontFamily: "Poppins",
                       fontWeight: FontWeight.w400),
                 ),
                 Text(
                   "The Skin Lab",
                   style: TextStyle(
                       color: Colors.black,
                       fontSize: 32,
                       fontFamily: "Poppins",
                       fontWeight: FontWeight.w700),
                 ),
               ],
              ),
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

                              ],
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 12.0, bottom: 5,top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("NOTE ",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w700,fontSize: 25),),
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
                            Text("Please take a close distance picture that only contains your skin.",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w400),),

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
                            Text("Try to avoid shadow and insufficient lighting conditions.",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w400),),

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




                      ],
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
