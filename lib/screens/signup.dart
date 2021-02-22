import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:my_cities_time/api/api_keys.dart';
import 'package:my_cities_time/main.dart';
import 'package:my_cities_time/models/skin.dart';
import 'package:my_cities_time/models/user.dart';
import 'package:my_cities_time/screens/Splash.dart';
import 'package:my_cities_time/screens/location.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/themes.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:my_cities_time/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';
class SignUp extends StatefulWidget {
  final Skin skinmodel;

  const SignUp({Key key, this.skinmodel}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
bool loader=false;
  TextEditingController email=TextEditingController(),username=TextEditingController(),password=TextEditingController(),confirm_password=TextEditingController();
  loc.Location location = loc.Location();//explicit reference to the Location class
  Future _checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkGps();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?AssetImage("assets/images/nightback2.jpg"): AssetImage("assets/images/back2.jpg"),
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
                      height: MediaQuery.of(context).size.height * 1.2,
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
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,left: 25,right: 25),
                                  child: Text(
                                    "Email",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,left: 10,right: 10),
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: email,
                                    autofocus: false,
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xfff3f3f3),
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
                                SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,left: 25,right: 25),
                                  child: Text(
                                    "Username",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top:8.0,left: 10,right: 10),
                                  child: TextField(
                                    autofocus: false,
                                    controller: username,
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xfff3f3f3),
                                      hintText: 'Username',
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
                                SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,left: 25,right: 25),
                                  child: Text(
                                    "Password",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top:8.0,left: 10,right: 10),
                                  child: TextField(
                                    autofocus: false,
                                    controller: password,
                                    obscureText: true,
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xfff3f3f3),
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
                                SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0,left: 25,right: 25),
                                  child: Text(
                                    "Confirm Password",
                                    style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets.only(top:8.0,left: 10,right: 10),
                                  child: TextField(
                                    autofocus: false,
                                    controller: confirm_password,
                                    obscureText: true,
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xfff3f3f3),
                                      hintText: 'Confirm Password',
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

                                SizedBox(height: 10,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    loader?SpinKitRipple(color: fontOrange,size: 40,):      Padding(
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
                                          signup();

                                        },
                                        color: fontOrange,
                                        textColor: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0,
                                              left: 20.0,
                                              bottom: 10,
                                              top: 10),
                                          child: Text("Sign Up",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
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
                                      "Sign Up With",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: fontOrange,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    Image.asset(
                                      'assets/images/one.PNG',

                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 30,),
                                    Image.asset(
                                      'assets/images/two.PNG',

                                      fit: BoxFit.cover,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Sign Up later",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: fontOrange,
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
            ),
          ],
        ),
      ),
    );
  }
  signup() async {
    setState(() {
      loader=true;
    });

    WeatherFactory wf = new WeatherFactory(ApiKey.OPEN_WEATHER_MAP);
    var state = Provider.of<AuthState>(context, listen: false);

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    final coordinates = new Coordinates(
        position.latitude,  position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    Weather weather = await wf.currentWeatherByLocation(position.latitude, position.longitude);

    // if(check()==true){
    //   print(check());
    //   showsnackbartop("Signup Error", "Field missing", 4,error, error, error, context);
    //
    // }
    if(!(password.text.contains(confirm_password.text))){
      setState(() {
        loader=false;
      });
      showsnackbartop("Password", "Password are not same", 4,error, error, error, context);
return;

    }
    Users users=Users(
      username: username.text,
      confirm_password: confirm_password.text,
      email: email.text,
      password: password.text,

    );
    try {
      await state.createUser(users);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Skin skinmodel = widget.skinmodel;
      skinmodel.city = addresses.first.locality;
      skinmodel.temperature = weather.temperature.celsius.toString();
      skinmodel.weather_detail = weather.weatherDescription;
      skinmodel.weathericon = weather.weatherIcon;
      DateTime now = new DateTime.now();
      DateTime date = new DateTime(now.year, now.month, now.day);
      skinmodel.date = date.toString();
      skinmodel.time = DateFormat.Hms().format(now);
      setState(() {
        loader = false;
      });

      kDatabase.child('skin').child(state.userModel.userId)
        ..child(addresses.first.locality).child(DateTime
            .now()
            .millisecondsSinceEpoch
            .toString()).set(
            skinmodel.toJson()
        ).then((value) => {
          prefs.setString("location", addresses.first.locality).then((
              bool success) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                SplashPage()), (Route<dynamic> route) => false);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SplashPage()),
            // );
          })
        });


    }catch(e){

      showsnackbartop("Registration Error", "Error registering this user", 4, Colors.red,Colors.red, Colors.red, context);
    }
    setState(() {
      loader = false;
    });






  }
  bool check(){
    if(email.text==null||email.text==""||username.text==null||username.text==""||password.text==null||password.text==""||confirm_password.text==""||confirm_password.text!=null){
      return true;

    }
    return false;

  }
}
