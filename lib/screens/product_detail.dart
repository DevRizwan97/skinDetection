import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/utils/constants.dart';

class ProductDetail extends StatefulWidget {
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/photo.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.2),
                    offset: Offset(0, -4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8,bottom: 8),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .97,
                    child: Column(

                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Ambre Solaire UV Ski",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 2,),
                            Text(
                              "UV Ski SPF 50+ Suncream",
                              style: TextStyle(
                                  color: fontOrange,
                                  fontSize: 13,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 2,),
                            Text(
                              "Price: 11",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 13,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 2,),
                            Text(
                              "Size: 30ml",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 13,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 2,),
                            Text(
                              "SPF Factor: 50",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 13,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),

                        Padding(
                          padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pros",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8,right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "UVA & UVB",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 2,),
                                  Text(
                                    "Water Resistance",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 2,),
                                  Text(
                                    "Kids Friendly",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 2,),
                                  Text(
                                    "Extreme Cold Conditions",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400),
                                  ),

                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),

                        Padding(
                          padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0,right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget lacus facilisis, dictum odio ut, egestas mauris. Vivamus euismod porta egestas. Maecenas auctor vestibulum erat non ornare. Phasellus sed pharetra odio, id interdum urna. Nunc consectetur ullamcorper venenatis. Vivamus eu condimentum augue, at fringilla tellus. Maecenas convallis nunc vitae commodo vestibulum. Maecenas et metus a ante lobortis cursus sit amet eget dolor. Nunc scelerisque aliquet erat, sed congue purus egestas ut.Sed vitae interdum lorem. Vivamus fringilla ullamcorper dui sed consequat. Quisque eget est semper, dignissim felis ut, venenatis mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi feugiat tristique dolor at ullamcorper. In magna nibh, sodales vitae euismod in, sollicitudin a dui. Fusce ultricies, lectus nec convallis dictum, justo est congue neque, at facilisis felis magna in sem. Sed a nulla faucibus, porta justo rutrum, facilisis enim. Mauris fringilla viverra nulla vitae ullamcorper. Nunc ex sem, congue lacinia quam quis, fringilla efficitur lorem.",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400),
                              ),



                            ],
                          ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              onPressed: (){},
                              color: fontOrange,
                              textColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 12.0,
                                    bottom: 12.0,
                                    right: 40,
                                    left: 40),
                                child: Text("Buy",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "OpenSans")),
                              ),
                            ),
                          ],
                        ),


                      ],

                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
