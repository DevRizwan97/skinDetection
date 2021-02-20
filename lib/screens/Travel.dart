import 'dart:convert';

import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart' as mapbox;
import 'package:my_cities_time/api/api_keys.dart';
import 'package:my_cities_time/api/http_exception.dart';
import 'package:my_cities_time/main.dart';
import 'package:my_cities_time/models/city_weather.dart';
import 'package:my_cities_time/screens/blog.dart';
import 'package:my_cities_time/screens/the_protection_shop.dart';
import 'package:my_cities_time/screens/the_skin_lab.dart';
import 'package:my_cities_time/shared/widgets/DrawerWidget.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:my_cities_time/screens/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
class Travel extends StatefulWidget {
  @override
  _TravelState createState() => _TravelState();
}

class _TravelState extends State<Travel> with SingleTickerProviderStateMixin  {
  TabController tabController;bool loader=false;
  List<mapbox.LatLng> lating=new List<mapbox.LatLng>();


  List<List<mapbox.LatLng>> final_lating=new  List<List<mapbox.LatLng>>();
  Iterable markers = [];
  final mapbox.LatLng center = const mapbox.LatLng(24.580664, 67.5563837);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    _fetchWeatherWithLocation().catchError((error) {
      // _fetchWeatherWithCity();
    });
  }  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }TabBar _getTabBar() {
    return TabBar(
      indicatorColor:Colors.orange.shade300,

      tabs: <Widget>[
        Tab(child: Text("Travel Destination",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15),),),
        Tab(child: Text("Suntan Roadmap",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 15),),),
      ],
      controller: tabController,
    );
  }    List<CityWeather> weathers=List<CityWeather>();
  Future getallweatherdata({double latitude, double longitude}) async {

    setState(() {
      loader=true;
    });
    final url =
        '${ApiKey.baseUrl}/data/2.5/find?lat=$latitude&lon=$longitude&cnt=5&appid=${ApiKey.OPEN_WEATHER_MAP}';
    print("hassan");
    print('fetching $url');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    Iterable l = json.decode(res.body)["list"];
    setState(() {

      weathers= List<CityWeather>.from(l.map((model)=> CityWeather.fromJson(model)));
      print(weathers[0].cityName);
      loader=false;
    });

  }

getmarkers()
{
setState(() {
  loader=true;
});

  var state = Provider.of<AuthState>(context, listen: false);
print("getmarkers");
for(int i=0;i<state.all_skin_data.length;i++){
    mapbox.LatLng latLngMarker = mapbox.LatLng(state.all_skin_data[i].lat, state.all_skin_data[i].long);
lating.add(latLngMarker);

    print(lating);
    // return Marker(markerId: MarkerId("marker$i"), position: latLngMarker,infoWindow: InfoWindow(
    //   title: 'City',
    //   snippet: state.all_skin_data[i].city,
    // ), );

  }

  setState(() {
   // markers=_markers;
 final_lating.add(lating);

    loader=false;
  });

//  mapController.addFill(
//     mapbox.FillOptions(
// geometry: final_lating,
//       fillColor: "#FFFFFF",
//       fillOutlineColor: "#FF0000",
//       fillOpacity: 0.6,
//     )
// );
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
    setState(() {
      loader = true;
    });
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(position.longitude);
 // lating  =mapbox.LatLng(position.latitude, position.longitude);
    // await getweather(position);

    await (getallweatherdata(
        latitude: position.latitude, longitude: position.longitude));
    getmarkers();
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
  TabBarView _getTabBarView(tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,

    );
  }
  void onStyleLoadedCallback() {}
  mapbox.MapboxMapController mapController;

  void _onMapCreated(mapbox.MapboxMapController controller) {
    mapController = controller;

  }
  // drawFill(features) async {
  //   // Map<String, dynamic> feature = jsonDecode(features[0]);
  //   // if (feature['geometry']['type'] == 'Polygon') {
  //   //   vr coordinates = feature['geometry']['coordinates'];
  //   //   List<List<mapbox.LatLng>> geometry = lating.map(
  //   //               (l) => mapbox.LatLng(l[1],l[0])
  //   //       ).toList().cast<mapbox.LatLng>();
  //     mapbox.Fill fill = await mapController.addFill(
  //         mapbox.FillOptions(
  //
  //           fillColor: "#FF0000",
  //           fillOutlineColor: "#FF0000",
  //           fillOpacity: 0.6,
  //         )
  //     );
  //     // setState(() {
  //     //   _selectedFill = fill;
  //     // });
  //  // }
  // }
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context, listen: false);
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
            image: AssetImage("assets/images/newbg.jpg"),
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
                    padding: const EdgeInsets.only(top: 100, left: 40),
                    child: Text(
                      "Travel",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  _getTabBar(),
                  Container(
                    height: MediaQuery.of(context).size.height ,
                    child: _getTabBarView(
                      <Widget>[
                        loader?SpinKitRipple(color:fontOrange,size:40):Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children:List.generate(weathers==null?0:weathers.length,(index){
                                return   Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0, bottom: 5,top: 15),
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
                                          padding: const EdgeInsets.only(
                                              top: 20.0, left: 30, bottom: 20, right: 20),
                                          child: Row(

                                            children: [


                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Text("${weathers[index].cityName}",style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "OpenSans",
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 18
                                                      ),),
                                                    ),
                                                  ),
                                                  Row(

                                                    children: [
                                                      Text(
                                                        "UV Index : ",
                                                        style: TextStyle(
                                                            color: fontOrange,
                                                            fontFamily: "OpenSans",
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 16),
                                                      ),
                                                      Text("10",style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "OpenSans",
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
                                                            fontFamily: "OpenSans",
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 16),
                                                      ),
                                                      Text("${weathers[index].temperature.celsius.toString()} \u00B0C",style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "OpenSans",
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
                                                            fontFamily: "OpenSans",
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 16),
                                                      ),
                                                      Text("${weathers[index].description}",style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "OpenSans",
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 16),),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5,),
                                                  // Row(
                                                  //   children: [
                                                  //     Text(
                                                  //       "Peak UVI Time : ",
                                                  //       style: TextStyle(
                                                  //           color: fontOrange,
                                                  //           fontFamily: "OpenSans",
                                                  //           fontWeight: FontWeight.w700,
                                                  //           fontSize: 16),
                                                  //     ),
                                                  //     Text("2:10 PM",style: TextStyle(
                                                  //         color: Colors.black,
                                                  //         fontFamily: "OpenSans",
                                                  //         fontWeight: FontWeight.w700,
                                                  //         fontSize: 16),),
                                                  //   ],
                                                  // ),

                                                ],
                                              ),

                                              Icon(
                                                getIconData(weathers[index].iconCode),
                                                color: Colors.black,
                                                size: 60,
                                              ),
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
                                );
                              }),

                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0, bottom: 5,top: 15),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height * 0.24,
                                    child:

                                    Card(
                                        color: cardColor,
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15)),
                                        ),
                                        child: loader?SpinKitRipple(color:fontOrange,size:40):
                                        mapbox.MapboxMap(
                                          accessToken: 'pk.eyJ1IjoiaGFzc2FucmVobWFuMDEzOTgiLCJhIjoiY2tqY25lcnIyMmFhYTJ6bnl2MGthamZiZyJ9.ZImRGisXPJXqjde9Ltu3tg',
                                          onMapCreated: _onMapCreated,
                                          onStyleLoadedCallback: () => onStyleLoaded(mapController),
                                          initialCameraPosition: mapbox.CameraPosition(
                                            target: center,
                                            zoom: 0,
                                          ),
                                          annotationOrder: const [
                                            mapbox.AnnotationType.line,
                                            mapbox.AnnotationType.symbol,
                                            mapbox.AnnotationType.circle,
                                            mapbox.AnnotationType.fill,
                                          ],
                                        ),
    //                                     GoogleMap(
    // mapType: MapType.normal,
    // markers:Set.from(
    //   markers,
    // ),
    //
    //                                       initialCameraPosition:
    //                                       CameraPosition(target: lating,  zoom: 0.0),
    //
    // // initialZoom: 20,
    //
    //
    // // onMapCreated: (GoogleMapController controller) {
    // // controller.setMapStyle(MapStyle.retro);
    // // _controller.complete(controller);
    // // },
    // ),

                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "My Training Records ",
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24),
                                      ),

                                      Container(
                                        width: double.infinity,
                                        height: MediaQuery.of(context).size.height*0.3,


                                        child:


                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: List.generate(state.all_skin_data==null?0:state.all_skin_data.length,(index){

                                                return  Padding(
                                                  padding: const EdgeInsets.only(right: 8,left: 8,top:30),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(state.all_skin_data[index].city,style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "OpenSans",fontWeight: FontWeight.w700),),
                                                        ],),
                                                      SizedBox(height: 10,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text("Date",style: TextStyle(color:fontOrange,fontSize: 16,fontWeight: FontWeight.w700,fontFamily: "OpenSans"),),
                                                              SizedBox(width: 5,),
                                                              Text(state.all_skin_data[index].date.substring(0,11),style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: "OpenSans"),),
                                                            ],
                                                          ),

                                                          Row(
                                                            children: [
                                                              Text("Time",style: TextStyle(color:fontOrange,fontSize: 16,fontWeight: FontWeight.w700,fontFamily: "OpenSans"),),
                                                              SizedBox(width: 5,),
                                                              Text(state.all_skin_data[index].time,style: TextStyle(color: Colors.black,fontSize:16,fontFamily: "OpenSans"),),
                                                            ],
                                                          ),
                                                        ],),
                                                    ],
                                                  ),
                                                );
                                              }),

                                              //
                                              // [
                                              //  ,
                                              //   Card(
                                              //     elevation: 0,
                                              //
                                              //     child: Padding(
                                              //       padding: const EdgeInsets.all(8.0),
                                              //       child: Column(
                                              //         children: [
                                              //           Row(
                                              //             mainAxisAlignment: MainAxisAlignment.center,
                                              //             crossAxisAlignment: CrossAxisAlignment.center,
                                              //             children: [
                                              //               Text("Barcelona",style: TextStyle(color: Colors.black,fontSize: 20),),
                                              //             ],),
                                              //           SizedBox(height: 10,),
                                              //           Row(
                                              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //             children: [
                                              //               Row(
                                              //                 children: [
                                              //                   Text("Date",style: TextStyle(color:fontOrange,fontSize: 20,fontWeight: FontWeight.w700),),
                                              //                   SizedBox(width: 10,),
                                              //                   Text("2019-07-21",style: TextStyle(color: Colors.black,fontSize: 20),),
                                              //                 ],
                                              //               ),
                                              //
                                              //               Row(
                                              //                 children: [
                                              //                   Text("Time",style: TextStyle(color:fontOrange,fontSize: 20,fontWeight: FontWeight.w700),),
                                              //                   SizedBox(width: 10,),
                                              //                   Text("3 Hours",style: TextStyle(color: Colors.black,fontSize: 20),),
                                              //                 ],
                                              //               ),
                                              //             ],),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ),
                                              //   Card(
                                              //     elevation: 0,
                                              //
                                              //     child: Padding(
                                              //       padding: const EdgeInsets.all(8.0),
                                              //       child: Column(
                                              //         children: [
                                              //           Row(
                                              //             mainAxisAlignment: MainAxisAlignment.center,
                                              //             crossAxisAlignment: CrossAxisAlignment.center,
                                              //             children: [
                                              //               Text("Barcelona",style: TextStyle(color: Colors.black,fontSize: 20),),
                                              //             ],),
                                              //           SizedBox(height: 10,),
                                              //           Row(
                                              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //             children: [
                                              //               Row(
                                              //                 children: [
                                              //                   Text("Date",style: TextStyle(color:fontOrange,fontSize: 20,fontWeight: FontWeight.w700),),
                                              //                   SizedBox(width: 10,),
                                              //                   Text("2019-07-21",style: TextStyle(color: Colors.black,fontSize: 20),),
                                              //                 ],
                                              //               ),
                                              //
                                              //               Row(
                                              //                 children: [
                                              //                   Text("Time",style: TextStyle(color:fontOrange,fontSize: 20,fontWeight: FontWeight.w700),),
                                              //                   SizedBox(width: 10,),
                                              //                   Text("3 Hours",style: TextStyle(color: Colors.black,fontSize: 20),),
                                              //                 ],
                                              //               ),
                                              //             ],),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ],
                                            ),
                                          ),
                                        ),
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
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void onStyleLoaded(mapbox.MapboxMapController controller) {
    // controller.addSymbol(
    //   mapbox. SymbolOptions(
    //     geometry: mapbox.LatLng(
    //       center.latitude,
    //       center.longitude,
    //     ),
    //     iconImage: "airport-15",
    //   ),
    // );
    for(int i=0;i<lating.length;i++) {
      mapController.addLine(
        mapbox.LineOptions(
          draggable: false,
          lineColor: "#ff0000",
          lineWidth: 7.0,
          lineOpacity: 3,
          geometry: [

            mapbox.LatLng(
                lating[i].latitude, lating[i].longitude + 1),
            mapbox.LatLng(lating[i].latitude, lating[i].longitude),
            mapbox.LatLng(
                lating[i].latitude + 1,lating[i].longitude + 1),
            mapbox.LatLng(
                lating[i].latitude + 1, lating[i].longitude),
          ],
        ),
      );
    }
    // controller.addLine(
    //   mapbox.LineOptions(
    //     draggable: false,
    //     lineColor: "#ff0000",
    //     lineWidth: 7.0,
    //     lineOpacity: 1,
    //     geometry: [
    //
    //       mapbox.LatLng(35.3649902, 32.0593003),
    //       mapbox.LatLng(35.3649902, 31.1187944),
    //       mapbox.LatLng(37.6995850, 32.0593003),
    //       mapbox.LatLng(37.6995850, 31.1187944),
    //     ],
    //   ),
    // );
    // controller.addFill(
    //   mapbox.FillOptions(
    //     draggable: false,
    //     fillColor: "#008888",
    //     fillOpacity: 0.3,
    //     geometry: [
    //       [
    //         mapbox.LatLng(35.3649902, 32.0593003),
    //         mapbox.LatLng(34.9475098, 31.1187944),
    //         mapbox.LatLng(36.7108154, 30.7040582),
    //         mapbox.LatLng(37.6995850, 33.6512083),
    //         mapbox.LatLng(35.8648682, 33.6969227),
    //         mapbox.LatLng(35.3814697, 32.0546447),
    //       ]
    //     ],
    //   ),
    // );
  }
}