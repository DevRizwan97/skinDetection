
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/utils/constants.dart';

class TheProtectionShop extends StatefulWidget {
  @override
  _TheProtectionShopState createState() => _TheProtectionShopState();
}

class _TheProtectionShopState extends State<TheProtectionShop> {
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
                "The Protection Shop",
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

            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.23,
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
                            padding: const EdgeInsets.only(top:20.0,left: 20,bottom: 20,right: 20),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Ayush",style: TextStyle(fontWeight: FontWeight.w700,fontFamily: "Poppins",fontSize: 15),),
SizedBox(width: 50,),
                                        Text("\$9.9",style: TextStyle(color: fontOrange,fontFamily: "Poppins",fontSize: 15),),
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Text("Pocket Suns Cream",style: TextStyle(fontSize: 13,fontFamily: "Poppins"),),
                                    SizedBox(height: 8,),
                                    Text("SPF50+ 30ml",style: TextStyle(fontSize: 13,fontFamily: "Poppins"),),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.sync,color: fontOrange,size: 30,),
                                    SizedBox(height: 20,),
                                    Icon(Icons.favorite,color: Colors.red,size: 30),


                                  ],
                                ),
                                Spacer(),
                                Image.asset(
                                  'assets/images/photo.jpg',
                                  width: 100.0,
                                  height: 100.0,
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






                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
