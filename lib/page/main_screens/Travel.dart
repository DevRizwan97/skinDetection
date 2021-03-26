import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_cities_time/page/main_screens/weather_screen.dart';
import 'package:uuid/uuid.dart';

import 'package:geocoder/geocoder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mapbox_gl/mapbox_gl.dart' as mapbox;
import 'package:my_cities_time/api/api_keys.dart';
import 'package:my_cities_time/api/http_exception.dart';
import 'package:my_cities_time/models/city_weather.dart';
import 'package:my_cities_time/widgets/DrawerWidget.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:my_cities_time/models/weather.dart';
import 'package:http/http.dart' as http;

class Travel extends StatefulWidget {
  @override
  _TravelState createState() => _TravelState();
}

class _TravelState extends State<Travel> with SingleTickerProviderStateMixin {
  TabController tabController;
  bool loader = false;
  TextEditingController searchcontroller = TextEditingController();
  var uuid = new Uuid();
  List<mapbox.LatLng> lating = new List<mapbox.LatLng>();

  List<List<mapbox.LatLng>> final_lating = new List<List<mapbox.LatLng>>();
  Iterable markers = [];
  final mapbox.LatLng center = const mapbox.LatLng(24.580664, 67.5563837);

  List<CityWeather> weathers = List<CityWeather>();

  List<Weather> searchweather = List<Weather>();

  String _sessionToken;

  List<dynamic> _placeList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 1, vsync: this);

    searchcontroller.addListener(() {
      _onChanged();
    });
    _fetchWeatherWithLocation().catchError((error) {
      // _fetchWeatherWithCity();
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      drawer: DrawerWidget(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bggg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150, left: 40),
                    child: Text(
                      "Explore",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  _getTabBar(),
                  Center(
                    child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.only(top: 20),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: fontOrange,
                          ),
                          child: TextField(

                            controller: searchcontroller,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.solid,
                                    color: fontOrange),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(25.0),
                                ),
                              ),
                              hintText: 'Search..',
                              fillColor: Colors.white,
                              filled: true,
                              focusColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                            ),
                          ),
                        )),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: _getTabBarView(
                      <Widget>[
                        loader
                            ? SpinKitRipple(color: Colors.black, size: 40)
                            : SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(
                                      searchcontroller.text != null ||
                                              searchcontroller.text.contains("")
                                          ? (state.top_three == null
                                              ? 0
                                              : state.top_three.length)
                                          : (searchweather == null
                                              ? 0
                                              : searchweather.length <= 0
                                                  ? 0
                                                  : searchweather.length),
                                      (index) {
                                    if (index < searchweather.length)
                                      return GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              searchcontroller.text =
                                                  _placeList[index]
                                                      ["description"];
//              _placeList.clear();
                                            });
                                            var addresses = await Geocoder.local
                                                .findAddressesFromQuery(
                                                    searchweather[index]
                                                        .cityName);

                                            var first = addresses.first;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WeatherScreen(
                                                        lat: first.coordinates
                                                            .latitude,
                                                        long: first.coordinates
                                                            .longitude,
                                                      )),
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0,
                                                right: 12.0,
                                                bottom: 5,
                                                top: 15),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.24,
                                              child: Card(
                                                  color: cardColor,
                                                  elevation: 5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Center(
                                                            child: Text(
                                                              "${searchweather[index].cityName}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "OpenSans",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 18),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Temprature : ",
                                                                style: TextStyle(
                                                                    color:
                                                                        fontOrange,
                                                                    fontFamily:
                                                                        "OpenSans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              Text(
                                                                "${double.parse(searchweather[index].temperature.celsius.toString()).floorToDouble().toString()} \u00B0C",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        "OpenSans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16),
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
                                                                    color:
                                                                        fontOrange,
                                                                    fontFamily:
                                                                        "OpenSans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              Text(
                                                                "${searchweather[index].description}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontFamily:
                                                                        "OpenSans",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                        ],
                                                      ),
                                                      Icon(
                                                        getIconData(
                                                            searchweather[index]
                                                                .iconCode),
                                                        color: Colors.black,
                                                        size: 60,
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ));
                                    else
                                      return GestureDetector(
                                        onTap: () async {
                                          var addresses = await Geocoder.local
                                              .findAddressesFromQuery(state
                                                  .top_three[index].cityName);

                                          var first = addresses.first;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WeatherScreen(
                                                      lat: first
                                                          .coordinates.latitude,
                                                      long: first.coordinates
                                                          .longitude,
                                                    )),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0,
                                              right: 12.0,
                                              bottom: 5,
                                              top: 15),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.24,
                                            child: Card(
                                                color: cardColor,
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                          topRight:
                                                              Radius.circular(
                                                                  15),
                                                          topLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15)),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            "${state.top_three[index].cityName}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    "OpenSans",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Temprature : ",
                                                              style: TextStyle(
                                                                  color:
                                                                      fontOrange,
                                                                  fontFamily:
                                                                      "OpenSans",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 16),
                                                            ),
                                                            Text(
                                                              "${double.parse(state.top_three[index].temperature.celsius.toString()).floorToDouble().toString()} \u00B0C",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "OpenSans",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
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
                                                                  color:
                                                                      fontOrange,
                                                                  fontFamily:
                                                                      "OpenSans",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 16),
                                                            ),
                                                            Text(
                                                              "${state.top_three[index].description}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "OpenSans",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
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
                                                              "UVI Index : ",
                                                              style: TextStyle(
                                                                  color:
                                                                      fontOrange,
                                                                  fontFamily:
                                                                      "OpenSans",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 16),
                                                            ),
                                                            Text(
                                                              "${state.top_three[index].uv_value}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "OpenSans",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),

                                                    Icon(
                                                      getIconData(state
                                                          .top_three[index]
                                                          .iconCode),
                                                      color: Colors.black,
                                                      size: 60,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ),
                                      );
                                  }),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  TabBar _getTabBar() {
    return TabBar(
      indicatorColor: Colors.orange.shade300,
      tabs: <Widget>[
        Tab(
          child: Text(
            "Travel Destination",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
        // Tab(child: Text("Suntan Roadmap",style: TextStyle(color:  Colors.black,fontWeight: FontWeight.w700,fontSize: 15),),),
      ],
      controller: tabController,
    );
  }


  Future<Weather> getWeatherData(String cityName) async {
    const baseUrl = 'http://api.openweathermap.org';
    final url =
        '$baseUrl/data/2.5/weather?q=$cityName&appid=4598e3e8b70d175fd36e3963636ea9e1';
    print('fetching $url');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }

  Future getallweatherdata({double latitude, double longitude}) async {
    setState(() {
      loader = true;
    });

    final url =
        '${ApiKey.baseUrl}/data/2.5/find?lat=$latitude&lon=$longitude&cnt=5&appid=${ApiKey.OPEN_WEATHER_MAP}';
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    Iterable l = json.decode(res.body)["list"];
    setState(() {
      weathers =
      List<CityWeather>.from(l.map((model) => CityWeather.fromJson(model)));
      print(weathers[0].cityName);
      loader = false;
    });
  }

  getmarkers() {
    setState(() {
      loader = true;
    });

    var state = Provider.of<AuthState>(context, listen: false);
    for (int i = 0; i < state.all_skin_data.length; i++) {
      mapbox.LatLng latLngMarker = mapbox.LatLng(
          state.all_skin_data[i].lat, state.all_skin_data[i].long);
      lating.add(latLngMarker);

    }

    setState(() {
      final_lating.add(lating);

      loader = false;
    });

  }


  _fetchWeatherWithLocation() async {
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

  TabBarView _getTabBarView(tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,
    );
  }

  void onStyleLoadedCallback() {}
  mapbox.MapboxMapController mapController;


  void _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(searchcontroller.text);
  }

  void getSuggestion(String input) async {
    setState(() {
      loader = true;
      _placeList.clear();
      searchweather.clear();
    });
    String kPLACES_API_KEY = "AIzaSyCj4FDxRHoIy91uBXhz_NqGpksKDB-cECw";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(request);
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
        print("hassan");
        print(_placeList);
      });
      await getplaces();
    } else {
      setState(() {
        loader = false;
      });
      throw Exception('Failed to load predictions');
    }
  }

  getplaces() async {
    searchweather.clear();
    List result = _placeList.toSet().toList();
    for (int i = 0; i < result.length; i++) {
      Weather w;
      try {
        w = await (getWeatherData(
            result[i]['structured_formatting']['main_text'].toString()));

        setState(() {
          if (contains(searchweather, w.cityName)) {
            i++;
          } else {
            searchweather.add(w);
          }
          //
        });
      } catch (Exception) {
        i++;
      }
    }
    setState(() {
      loader = false;
    });
  }

  bool contains(List<Weather> element, String cityname) {
    for (Weather e in element) {
      if (e.cityName == cityname) return true;
    }
    return false;
  }
  void onStyleLoaded(mapbox.MapboxMapController controller) {
    for (int i = 0; i < lating.length; i++) {
      mapController.addCircle(mapbox.CircleOptions(
          draggable: false,
          circleColor: "#FF0000",
          circleRadius: 5.0,
          circleOpacity: 3,
          geometry: lating[i]));
    }
  }
}
