import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_cities_time/api/api_keys.dart';
import 'package:my_cities_time/api/http_exception.dart';
import 'package:my_cities_time/api/weather_api_client.dart';
import 'package:my_cities_time/bloc/weather_bloc.dart';
import 'package:my_cities_time/bloc/weather_event.dart';
import 'package:my_cities_time/bloc/weather_state.dart';
import 'package:my_cities_time/flutter_datetime_picker.dart';
import 'package:my_cities_time/models/weather.dart' as weather;
import 'package:my_cities_time/repository/weather_repository.dart';
import 'package:my_cities_time/shared/widgets/DrawerWidget.dart';
import 'package:my_cities_time/screens/Travel.dart';
import 'package:my_cities_time/screens/blog.dart';
import 'package:my_cities_time/screens/the_protection_shop.dart';
import 'package:my_cities_time/screens/the_skin_lab.dart';
import 'package:my_cities_time/screens/weather_screen.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/themes.dart';
import 'package:my_cities_time/utils/WeatherIconMapper.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:my_cities_time/widgets/weather_widget.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/weather.dart';

import '../main.dart';

class Location extends StatefulWidget {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
          httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_MAP));

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool loader = false;
  String weather_temp, weather_desc, weather_icon, uvi_index;
  WeatherBloc _weatherBloc;
  String _cityName = 'karachi';
  SharedPreferences prefs;

  _fetchWeatherWithLocation() async {

   prefs = await SharedPreferences.getInstance();
    var permissionHandler = PermissionHandler();
    var permissionResult = await permissionHandler
        .requestPermissions([PermissionGroup.locationWhenInUse]);

    switch (permissionResult[PermissionGroup.locationWhenInUse]) {
      case PermissionStatus.denied:
      case PermissionStatus.unknown:
        print('location permission denied');
        _showLocationDeniedDialog(permissionHandler);
        throw Error();
    }
    setState(() {
      loader = true;
    });
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

    await getweather(position);

   await (onecallweatherdata(
          latitude: position.latitude, longitude: position.longitude));

    // _weatherBloc.dispatch(FetchWeather(
    //     longitude: position.longitude, latitude: position.latitude));
  }

  void _showLocationDeniedDialog(PermissionHandler permissionHandler) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Location is disabled :(',
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Enable!',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
                onPressed: () {
                  permissionHandler.openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  getweather(Position position) async {
    WeatherFactory wf = new WeatherFactory(ApiKey.OPEN_WEATHER_MAP);
    Weather weather = await wf.currentWeatherByLocation(
        position.latitude, position.longitude);
    setState(() {
      weather_temp = weather.temperature.celsius.toString();
      weather_desc = weather.weatherDescription;
      weather_icon = weather.weatherIcon;
      _cityName=weather.areaName;
      loader = false;
    });
  }
String suntime="0";
  Future onecallweatherdata({double latitude, double longitude}) async {
    final url =
        '${ApiKey.baseUrl}/data/2.5/onecall?lat=$latitude&lon=$longitude&appid=${ApiKey.OPEN_WEATHER_MAP}';
    print('fetching $url');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    setState(() {
      uvi_index=weatherJson['current']['uvi'].toString();
      prefs.setString("uvi_index",uvi_index);
    });

    var state = Provider.of<AuthState>(context, listen: false);
    List<Map> all_data=state.all_excel_data;
    // print(state.all_excel_data);
    for(int i=0;i<state.all_excel_data.length;i++){
      String uv=all_data[i]['uv'].toString();
   String uv_index=(int.parse(double.parse(uvi_index).floor().toString()).toString());
//print(uv==uv_index);
// print(state.all_excel_data[i]['uv'].contains(uvi_index));
// print(state.all_excel_data[i]['skintype'].contains(state.all_skin_data[state.all_skin_data.length-1].skintype));
//
      if(uv==uv_index&&all_data[i]['skintype'].toString()==state.all_skin_data[state.all_skin_data.length-1].skintype){
        setState(() {

          suntime=state.all_excel_data[i]['time'].toString();
          print("rafay");
        print(suntime);
        });
       // break;
      }
    }
   // return weatherJson['current']['uvi'].toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);

    _fetchWeatherWithLocation().catchError((error) {
      // _fetchWeatherWithCity();
    });
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context, listen: false);
    // _cityName = state.skin == null ? "karachi" : state.skin.city;
    return Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        drawer: DrawerWidget(),
        body: Container(
                width: MediaQuery.of(context).size.width,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage("assets/images/bggg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: loader
                    ? SpinKitRipple(
                  color: fontOrange,
                  size: 40,
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 150, left: 40, right: 8),
                      child: Text(
                       "Weather",
                        style: TextStyle(
                            color:  Colors.black,
                            fontSize: 32,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        _cityName,
                        style: TextStyle(
                            color: fontOrange,
                            fontSize: 32,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WeatherScreen()),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, bottom: 5),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.23,
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
                                        padding: const EdgeInsets.only(
                                            top: 20.0,
                                            left: 20,
                                            bottom: 20,
                                            right: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 10,),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "UV Index : ",
                                                      style: TextStyle(
                                                          color: fontOrange,
                                                          fontFamily: "OpenSans",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                    ),
                                                    //state.skin==null?"":state.skin.uv_level
                                                    Text(
                                                      uvi_index == null
                                                          ? ""
                                                          : int.parse(double.parse(uvi_index).floor().toString()).toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "OpenSans",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Temperature : ",
                                                      style: TextStyle(
                                                          color: fontOrange,
                                                          fontFamily: "OpenSans",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      weather_temp==null?"":double.parse(weather_temp).round().toString() ,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "OpenSans",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Weather : ",
                                                      style: TextStyle(
                                                          color: fontOrange,
                                                          fontFamily: "OpenSans",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                     weather_desc==null?"": weather_desc + "",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "OpenSans",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                                // SizedBox(
                                                //   height: 5,
                                                // ),
                                                // Row(
                                                //   children: [
                                                //     Text(
                                                //       "Peak UVI Time : ",
                                                //       style: TextStyle(
                                                //           color: fontOrange,
                                                //           fontFamily: "OpenSans",
                                                //           fontWeight:
                                                //               FontWeight.w700,
                                                //           fontSize: 16),
                                                //     ),
                                                //     Text(
                                                //       "2:10 PM",
                                                //       style: TextStyle(
                                                //           color: Colors.black,
                                                //           fontFamily: "OpenSans",
                                                //           fontWeight:
                                                //               FontWeight.w700,
                                                //           fontSize: 16),
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  getIconData(weather_icon),
                                                  color: Colors.black,
                                                  size: 70,
                                                ),
                                              ],
                                            )
                                            // Image.asset(
                                            //   'assets/images/sun.png',
                                            //   width: 100,
                                            //   height: 100,
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ],
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, bottom: 5),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.24,
                                child: Card(
                                    color:cardColor,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0,
                                          left: 30,
                                          bottom: 20,
                                          right: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "👨  Your Skin Type : ",
                                                style: TextStyle(
                                                    color: fontOrange,
                                                    fontFamily: "OpenSans",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16),
                                              ),
                                              Container(
                                                width: 40.0,
                                                height: 20.0,
                                                child: Container(
                                                  decoration: new BoxDecoration(
                                                    color:state.all_skin_data == null
                                                        ? Colors.transparent
                                                        : Color(int.parse(state.all_skin_data[state.all_skin_data.length-1].skincolor
                                                            .replaceAll(
                                                                '#', '0xff'))),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                ),
                                              ),
                                              // Text("no. "+(state.skin==null?"":state.skin.skintype),style: TextStyle(
                                              //     color: Colors.black,
                                              //     fontFamily: "OpenSans",
                                              //     fontWeight: FontWeight.w700,
                                              //     fontSize: 16),),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset("assets/images/sun-protection (1).png",height: 20,width: 20,),
                                              SizedBox(width: 6,),
                                              Text(
                                                "Time To Sunburn : ",
                                                style: TextStyle(
                                                    color: fontOrange,
                                                    fontFamily: "OpenSans",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17),
                                              ),
                                              Text(
                                                suntime == null
                                                    ? ""
                                                    : int.parse(double.parse(suntime).floor().toString()).toString()+" minutes",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "OpenSans",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "⏰  SPF : ",
                                                style: TextStyle(
                                                    color: fontOrange,
                                                    fontFamily: "OpenSans",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17),
                                              ),
                                              Text(
                                                uvi_index==null?"":double.parse(uvi_index)<=3?"15+":double.parse(uvi_index)<=8?"30+":"50+",
                                                // (state.skin == null
                                                //     ? ""
                                                //     : state.skin.spf),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "OpenSans",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17),
                                              ),
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
                              padding: const EdgeInsets.only(
                                  top: 12.0, bottom: 12.0, right: 40, left: 40),
                              child: Container(
                                height: 50,

                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  onPressed: () {

                                    _showIntDialog();

                                    },
                                  color: fontOrange,
                                  textColor: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.alarm),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Set Up Your UV Alarm",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "OpenSans")),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 3.0, bottom: 12.0, right: 40, left: 40),
                              child: Container(
                                height: 50,

                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  onPressed: () {
        _showDialog1();

    //                                AndroidAlarmManager.periodic(
    // const Duration(seconds: 5),
    // // Ensure we have a unique alarm ID.
    // Random().nextInt(pow(2, 31).toInt()),
    // printHello,
    // );

                                  },
                                  color: fontOrange,
                                  textColor: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Text("Set up sunscreen Reminder",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "OpenSans")),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }

  IconData getIconData(String iconCode) {
    switch (iconCode) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }
  Future _showIntDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {

        return new NumberPickerDialog.integer(
          minValue: 1,
          title: Text("Setup UV Alarm"),
          maxValue: 10,
          step: 1,
          initialIntegerValue: 1,
        );
      },
    ).then((num value) {
      prefs.setString("uv", value.toString());
      print(value.toString());

                                     AndroidAlarmManager.periodic(
      const Duration(seconds: 5),
      // Ensure we have a unique alarm ID.
      Random().nextInt(pow(2, 31).toInt()),
      printHello,
      );
      // if (value != null) {
      //   setState(() => _currentIntValue = value);
      //   integerNumberPicker.animateInt(value);
      // }
    });
  }

  void _showDialog1() {
    DatePicker.showTime12hPicker(context, showTitleActions: true,

        onChanged: (date) {
      print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {

      Time notificationtime=Time(date.hour,date.minute,0);
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'your chairvnnel id', 'your channel name', 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,

          sound: RawResourceAndroidNotificationSound('slow_spring_board'),
          showWhen: false);
      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
      flutterLocalNotificationsPlugin.showDailyAtTime(0, "Sunscreen Remainder","Remainder for sun screeen", notificationtime,platformChannelSpecifics);

    }, currentTime: DateTime.now());

  }
  void printHello() async {

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    final url =
        '${ApiKey.baseUrl}/data/2.5/onecall?lat=${position.latitude}&lon=${position.longitude}&appid=${ApiKey.OPEN_WEATHER_MAP}';
    print('fetching $url');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    setState(() {
      uvi_index=weatherJson['current']['uvi'].toString();
 if(double.parse(uvi_index)<=double.parse(prefs.getString("uv"))){
   const AndroidNotificationDetails androidPlatformChannelSpecifics =
   AndroidNotificationDetails(
       'your channel id', 'your channel name', 'your channel description',
       importance: Importance.max,
       priority: Priority.high,
       playSound: true,

       sound: RawResourceAndroidNotificationSound('slow_spring_board'),
       showWhen: false);
   const NotificationDetails platformChannelSpecifics =
   NotificationDetails(android: androidPlatformChannelSpecifics);
   flutterLocalNotificationsPlugin.show(0, "UV Alarm", "UV index reached",platformChannelSpecifics);


 }
    });
    // return weatherJson['current']['uvi'].toString();
    // int ub=prefs.getInt("uv");
    // final DateTime now = DateTime.now();
    // final int isolateId = Isolate.current.hashCode;
    // print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
  }


}

class _IconData extends IconData {
  const _IconData(int codePoint)
      : super(
          codePoint,
          fontFamily: 'WeatherIcons',
        );
}
