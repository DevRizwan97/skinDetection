import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:intl/intl.dart';
import 'package:my_cities_time/api/api_keys.dart';
import 'package:my_cities_time/plugins/camera_camera.dart';
import 'package:my_cities_time/models/skin.dart';
import 'package:my_cities_time/page/main_screens/signup.dart';
import 'package:my_cities_time/widgets/DrawerWidget.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:my_cities_time/utils/helper.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:weather/weather.dart';

class TheSkinLab extends StatefulWidget {
  @override
  _TheSkinLabState createState() => _TheSkinLabState();
}

class _TheSkinLabState extends State<TheSkinLab> {
  File _image;
  bool loader = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      drawer: state.user != null ? DrawerWidget() : null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bggg.png"),
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
                    padding: const EdgeInsets.only(top: 150, left: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, " +
                              (state.userModel == null
                                  ? ""
                                  : state.userModel.username),
                          style: TextStyle(
                              color: fontOrange,
                              fontSize: 20,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Skin Lab",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 32,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12.0, bottom: 5),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.33,
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
                                        left: 50, right: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt,
                                                  size: 90,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9.0),
                                                  ),
                                                  onPressed: () {
                                                    _imgFromCamera();
                                                  },
                                                  color: fontOrange,
                                                  textColor: Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 40.0,
                                                            left: 40.0,
                                                            bottom: 10,
                                                            top: 10),
                                                    child: Text("Take Picture",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                "OpenSans")),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            9.0),
                                                  ),
                                                  onPressed: () {
                                                    _imgFromGallery();
                                                  },
                                                  color: fontOrange,
                                                  textColor: Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 30.0,
                                                            left: 30.0,
                                                            bottom: 10,
                                                            top: 10),
                                                    child: Text(
                                                        "Choose Picture",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                "OpenSans")),
                                                  ),
                                                ),
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
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 12.0, bottom: 5, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "NOTE ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "OpenSans",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 10.0,
                                      width: 10.0,
                                      decoration: new BoxDecoration(
                                        color: fontOrange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Pictures should only contain your skin.",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        // textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(
                                      color: fontOrange,
                                      height: 10,
                                      thickness: 1.5,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 10.0,
                                      width: 10.0,
                                      decoration: new BoxDecoration(
                                        color: fontOrange,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Avoid Shadow and overexposure.",
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        // textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "OpenSans",
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(
                                      color: fontOrange,
                                      height: 10,
                                      thickness: 1.5,
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  _imgFromCamera() async {
    File image = (await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Camera(
                  orientationEnablePhoto: CameraOrientation.all,
                  imageMask: CameraFocus.square(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ))));
    setState(() {
      _image = image;
      sendimagefile(_image);
    });
  }

  _imgFromGallery() async {
    File image = (await picker.ImagePicker.pickImage(
        source: picker.ImageSource.gallery, imageQuality: 50));

    setState(() {
      _image = image;
      sendimagefile(_image);
    });
  }

  sendimagefile(File file) async {
    setState(() {
      loader = true;
    });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // I am not connected to a mobile network.
      showsnackbartop("Network", "Connection error", 4, Colors.redAccent,
          Colors.red, Colors.red, context);
    } else {
      try {
        var postUri = Uri.parse(api_url);
        var request = new http.MultipartRequest("POST", postUri);
        request.files.add(new http.MultipartFile.fromBytes(
            'image', await File.fromUri(file.uri).readAsBytes()));
        request.files.add(
          http.MultipartFile(
            'image',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: "Skinimage",
          ),
        );
        // request.headers.addAll(headers);
        request.send().then((response) async {
          if (response.statusCode == 201 || response.statusCode == 200) {
            final respStr = await response.stream.bytesToString();
            final Map parsed = json.decode(respStr);
            final skinmodel = Skin.fromJson(parsed);
            WeatherFactory wf = new WeatherFactory(ApiKey.OPEN_WEATHER_MAP);
            var state = Provider.of<AuthState>(context, listen: false);

            Position position = await Geolocator()
                .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
            final coordinates =
                new Coordinates(position.latitude, position.longitude);
            var addresses =
                await Geocoder.local.findAddressesFromCoordinates(coordinates);
            DateTime now = new DateTime.now();
            DateTime date = new DateTime(now.year, now.month, now.day);
            skinmodel.date = date.toString();
            List months = [
              'jan',
              'feb',
              'mar',
              'apr',
              'may',
              'jun',
              'jul',
              'aug',
              'sep',
              'oct',
              'nov',
              'dec'
            ];
            skinmodel.month = months[now.month - 1];
            Weather weather = await wf.currentWeatherByLocation(
                position.latitude, position.longitude);

            skinmodel.lat = position.latitude == null ? 0 : position.latitude;
            skinmodel.long =
                position.longitude == null ? 0 : position.longitude;
            if (state.user != null) {
              skinmodel.city = addresses.first.locality;
              skinmodel.temperature = weather.temperature.celsius.toString();
              skinmodel.weather_detail = weather.weatherDescription;
              skinmodel.weathericon = weather.weatherIcon;

              skinmodel.time = DateFormat.Hms().format(now);

              kDatabase.child('skin').child(state.userModel.userId)
                ..child(addresses.first.locality)
                    .child(DateTime.now().millisecondsSinceEpoch.toString())
                    .set(skinmodel.toJson());
              setState(() {
                loader = false;
              });

              state.addskin(skinmodel);
              SweetAlert.show(context,
                  title: "Success", subtitle: "Successfully detected skin");
            } else {
              setState(() {
                loader = false;
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignUp(
                            skinmodel: skinmodel,
                          )));
            }
          } else {
            setState(() {
              loader = false;
            });
          }
        });
      } catch (e) {
        setState(() {
          loader = false;
        });
      }
      // I am connected to a wifi network.

    }
  }
}
