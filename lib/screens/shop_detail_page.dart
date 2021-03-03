import 'package:flutter/material.dart';
import 'package:my_cities_time/utils/constants.dart';

class ShopDetailPage extends StatefulWidget {
  @override
  _ShopDetailPageState createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends State<ShopDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,

        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: fontOrange,
            )),
      ),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product: ",
                        style: TextStyle(
                            fontFamily: "OpenSans", fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Ambre Solaire UV Ski",
                        style: TextStyle(
                            fontFamily: "OpenSans", fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "UV Ski SPF 50+ Suncream",
                        style: TextStyle(
                            fontFamily: "OpenSans", fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Price 11\u{20B9}",
                        style: TextStyle(
                            fontFamily: "OpenSans", fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Size: 30ml",
                        style: TextStyle(
                            fontFamily: "OpenSans", fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "SPF Factor:",
                        style: TextStyle(
                            fontFamily: "OpenSans", fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "50",
                        style: TextStyle(
                            fontFamily: "OpenSans", fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Spacer(),
                  Image.asset("assets/images/lotion.png",height: 150,width: 150,),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Pros:",
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "UVA and UVB",
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Water Resistance",
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Kids Friendly",
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "Extreme Cold Conditions",
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w400),
              ),



              SizedBox(
                height: 15,
              ),
              Text(
                "Website:",
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "www.facebook.com",
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w400),
              ),


              SizedBox(
                height: 15,
              ),
              Text(
                "Description:",
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w700),
              ), SizedBox(
                height: 4,
              ),
              Text(
                "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of  (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum,  comes from a line in section 1.10.32.",
                style: TextStyle(
                    fontFamily: "OpenSans", fontWeight: FontWeight.w400),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
