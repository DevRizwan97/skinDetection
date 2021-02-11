import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:my_cities_time/api/api_keys.dart';
import 'package:my_cities_time/models/skin.dart';
import 'package:my_cities_time/models/user.dart';
import 'package:my_cities_time/screens/Splash.dart';
import 'package:my_cities_time/screens/location.dart';
import 'package:my_cities_time/states/authstate.dart';
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
      loader?SpinKitRipple(color: fontOrange,size: 40,):Container(
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
                      height: MediaQuery.of(context).size.height * 0.9,
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
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email,
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
                                "Username",
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
                                  controller: username,
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    hintText: 'Username',
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
                                  controller: password,
                                  obscureText: true,
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
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Confirm Password",
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
                                  controller: confirm_password,
                                  obscureText: true,
                                  style: TextStyle(
                                      fontSize: 17.0, color: Colors.black),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    hintText: 'Confirm Password',
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
                                        signup();

                                      },
                                      color: fontOrange,
                                      textColor: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 30.0,
                                            left: 30.0,
                                            bottom: 10,
                                            top: 10),
                                        child: Text("Sign Up",
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
                                    "Sign Up With",
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
await state.createUser(users);
Skin skinmodel=widget.skinmodel;
skinmodel.city=addresses.first.locality;
skinmodel.temperature=weather.temperature.celsius.toString();
skinmodel.weather_detail=weather.weatherDescription;
skinmodel.weathericon=weather.weatherIcon;
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    skinmodel.date=date.toString();
    skinmodel.time=DateFormat.Hms().format(now);
    kDatabase.child('skin').child(state.userModel.userId)..child(addresses.first.locality).child(DateTime.now().millisecondsSinceEpoch.toString()).set(
        skinmodel.toJson()
    );

    setState(() {
      loader=false;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("location", addresses.first.locality).then((bool success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashPage()),
      );

    });

  }
  bool check(){
    if(email.text==null||email.text==""||username.text==null||username.text==""||password.text==null||password.text==""||confirm_password.text==""||confirm_password.text!=null){
      return true;

    }
    return false;

  }
}
