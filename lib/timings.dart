import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:http/http.dart' as http;
//import 'package:timezone/data/latest.dart' as tz;

class Timings extends StatefulWidget {
  @override
  _TimingsState createState() => _TimingsState();
}

class _TimingsState extends State<Timings> {
  String telAviv = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimeOfCountry();
  }

   getTimeOfCountry() async{
    var response = await http.get("https://www.amdoren.com/api/timezone.php?api_key=WYfrqEKbiL4mQXnXNXNwkKgbHz5Nxq&loc=Tel Aviv");
    var response1 = await http.get("https://www.amdoren.com/api/timezone.php?api_key=WYfrqEKbiL4mQXnXNXNwkKgbHz5Nxq&loc=New York");
    var response2 = await http.get("https://www.amdoren.com/api/timezone.php?api_key=WYfrqEKbiL4mQXnXNXNwkKgbHz5Nxq&loc=New York");
    var response3 = await http.get("https://www.amdoren.com/api/timezone.php?api_key=WYfrqEKbiL4mQXnXNXNwkKgbHz5Nxq&loc=New York");
    var response4 = await http.get("https://www.amdoren.com/api/timezone.php?api_key=WYfrqEKbiL4mQXnXNXNwkKgbHz5Nxq&loc=New York");

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse["time"].toString().split(" ")[1]);
      setState(() {
        telAviv = jsonResponse["time"].toString().split(" ")[1];
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg-1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:ListView(
           children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top:30,left: 8,right: 8),
                   child: Text("Local Time",style: TextStyle(
                       color:Colors.white,
                       fontSize: 32,
                     fontFamily: "Poppins",
                     fontWeight: FontWeight.w700
                   ),),
                 ),
                 SizedBox(height: 50,),
                 Padding(
                   padding: const EdgeInsets.only(left:12.0,right: 12.0,top: 5,bottom: 5),
                   child: Container(
                     height: 85,
                     child: Card(
                       elevation: 5,
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.only(
                               bottomRight: Radius.circular(15),
                               topRight: Radius.circular(15),
                               topLeft: Radius.circular(15),
                               bottomLeft: Radius.circular(15)),
                           ),
                       child: ListTile(
                         title: Text("Tel Aviv",style: TextStyle(color: purple,fontFamily: "Poppins",fontWeight: FontWeight.w700,fontSize: 17),),
                         subtitle: Text("GMT +2",style: TextStyle(color: blue,fontFamily: "Poppins",fontSize: 15),),
                         trailing: Text(telAviv == ""?"00:00":telAviv.split(":")[0]+":"+telAviv.split(":")[1],style: TextStyle(color:black,fontSize: 45,fontFamily: "Poppins"),),
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left:12.0,right: 12.0,top: 5,bottom: 5),
                   child: Container(
                     height: 85,
                     child: Card(
                       elevation: 5,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.only(
                             bottomRight: Radius.circular(15),
                             topRight: Radius.circular(15),
                             topLeft: Radius.circular(15),
                             bottomLeft: Radius.circular(15)),
                       ),
                       child: ListTile(
                         title: Text("London",style: TextStyle(color: purple,fontFamily: "Poppins",fontWeight: FontWeight.w700,fontSize: 17),),
                         subtitle: Text("GMT +2",style: TextStyle(color: blue,fontFamily: "Poppins",fontSize: 15),),
                         trailing: Text("16:45",style: TextStyle(color:black,fontSize: 45,fontFamily: "Poppins"),),
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left:12.0,right: 12.0,top: 5,bottom: 5),
                   child: Container(
                     height: 85,
                     child: Card(
                       elevation: 5,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.only(
                             bottomRight: Radius.circular(15),
                             topRight: Radius.circular(15),
                             topLeft: Radius.circular(15),
                             bottomLeft: Radius.circular(15)),
                       ),
                       child: ListTile(
                         title: Text("Paris",style: TextStyle(color: purple,fontFamily: "Poppins",fontWeight: FontWeight.w700,fontSize: 17),),
                         subtitle: Text("GMT +2",style: TextStyle(color: blue,fontFamily: "Poppins",fontSize: 15),),
                         trailing: Text("16:45",style: TextStyle(color:black,fontSize: 45,fontFamily: "Poppins"),),
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left:12.0,right: 12.0,top: 5,bottom: 5),
                   child: Container(
                     height: 85,
                     child: Card(
                       elevation: 5,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.only(
                             bottomRight: Radius.circular(15),
                             topRight: Radius.circular(15),
                             topLeft: Radius.circular(15),
                             bottomLeft: Radius.circular(15)),
                       ),
                       child: ListTile(
                         title: Text("New York",style: TextStyle(color: purple,fontFamily: "Poppins",fontWeight: FontWeight.w700,fontSize: 17),),
                         subtitle: Text("GMT +2",style: TextStyle(color: blue,fontFamily: "Poppins",fontSize: 15),),
                         trailing: Text("16:45",style: TextStyle(color:black,fontSize: 45,fontFamily: "Poppins"),),
                       ),
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left:12.0,right: 12.0,top: 5,bottom: 5),
                   child: Container(
                     height: 85,
                     child: Card(
                       elevation: 5,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.only(
                             bottomRight: Radius.circular(15),
                             topRight: Radius.circular(15),
                             topLeft: Radius.circular(15),
                             bottomLeft: Radius.circular(15)),
                       ),
                       child: ListTile(
                         title: Text("San Fransisco",style: TextStyle(color: purple,fontFamily: "Poppins",fontWeight: FontWeight.w700,fontSize: 17),),
                         subtitle: Text("GMT +2",style: TextStyle(color: blue,fontFamily: "Poppins",fontSize: 15),),
                         trailing: Text("16:45",style: TextStyle(color:black,fontSize: 45,fontFamily: "Poppins"),),
                       ),
                     ),
                   ),
                 ),



               ],
             ),
           ],
        ),
      ),
    );

  }
}
