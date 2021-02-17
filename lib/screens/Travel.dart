import 'dart:convert';

import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
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
  LatLng lating;


  Iterable markers = [];
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

getmarkers(){
setState(() {
  loader=true;
});
  var state = Provider.of<AuthState>(context, listen: false);

  Iterable _markers = Iterable.generate(state.all_skin_data.length, (i) {
    LatLng latLngMarker = LatLng(state.all_skin_data[i].lat, state.all_skin_data[i].long);

    return Marker(markerId: MarkerId("marker$i"), position: latLngMarker,infoWindow: InfoWindow(
      title: 'City',
      snippet: state.all_skin_data[i].city,
    ), );

  });
  setState(() {
    markers=_markers;
 loader=false;
  });

}

_fetchWeatherWithLocation() async {
    getmarkers();
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
  lating  =LatLng(position.latitude, position.longitude);
    // await getweather(position);

    await (getallweatherdata(
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
  TabBarView _getTabBarView(tabs) {
    return TabBarView(
      children: tabs,
      controller: tabController,

    );
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
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  _getTabBar(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: _getTabBarView(
                      <Widget>[
                        loader?SpinKitRipple(color:fontOrange,size:40):ListView(
                          children:List.generate(weathers==null?0:weathers.length,(index){
                            return   Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, bottom: 5),
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
                                                      fontFamily: "Poppins",
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
                                                        fontFamily: "Poppins",
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                  Text("10",style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Poppins",
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
                                                        fontFamily: "Poppins",
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                  Text("${weathers[index].temperature.celsius.toString()} \u00B0C",style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Poppins",
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
                                                        fontFamily: "Poppins",
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16),
                                                  ),
                                                  Text("${weathers[index].description}",style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Poppins",
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
                                              //           fontFamily: "Poppins",
                                              //           fontWeight: FontWeight.w700,
                                              //           fontSize: 16),
                                              //     ),
                                              //     Text("2:10 PM",style: TextStyle(
                                              //         color: Colors.black,
                                              //         fontFamily: "Poppins",
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
                        ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, bottom: 5),
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
                                    child: loader?SpinKitRipple(color:fontOrange,size:40):GoogleMap(
    mapType: MapType.normal,
    markers:Set.from(
      markers,
    ),

                                      initialCameraPosition:
                                      CameraPosition(target: lating, zoom: 15),

    // initialZoom: 20,


    // onMapCreated: (GoogleMapController controller) {
    // controller.setMapStyle(MapStyle.retro);
    // _controller.complete(controller);
    // },
    ),

                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 12.0, bottom: 5, top: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "My Training Records ",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height*0.3,


                                    child:


                                    ListView(
                                      children: List.generate(state.all_skin_data==null?0:state.all_skin_data.length,(index){

                                        return  Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text(state.all_skin_data[index].city,style: TextStyle(color: Colors.black,fontSize: 18,fontFamily: "Poppins",fontWeight: FontWeight.w700),),
                                                ],),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Date",style: TextStyle(color:fontOrange,fontSize: 16,fontWeight: FontWeight.w700,fontFamily: "Poppins"),),
                                                      SizedBox(width: 5,),
                                                      Text(state.all_skin_data[index].date.substring(0,11),style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: "Poppins"),),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text("Time",style: TextStyle(color:fontOrange,fontSize: 16,fontWeight: FontWeight.w700,fontFamily: "Poppins"),),
                                                      SizedBox(width: 5,),
                                                      Text(state.all_skin_data[index].time,style: TextStyle(color: Colors.black,fontSize:16,fontFamily: "Poppins"),),
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
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
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
}