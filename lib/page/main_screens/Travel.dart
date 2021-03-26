import 'dart:convert';

import 'package:charcode/charcode.dart';
import 'package:flutter/material.dart';
import 'package:my_cities_time/page/main_screens/weather_screen.dart';
import 'package:uuid/uuid.dart';

import 'package:geocoder/geocoder.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart' as mapbox;
import 'package:my_cities_time/api/api_keys.dart';
import 'package:my_cities_time/api/http_exception.dart';
import 'package:my_cities_time/main.dart';
import 'package:my_cities_time/models/city_weather.dart';
import 'package:my_cities_time/page/main_screens/blog.dart';
import 'package:my_cities_time/page/main_screens/the_protection_shop.dart';
import 'package:my_cities_time/page/main_screens/the_skin_lab.dart';
import 'package:my_cities_time/widgets/DrawerWidget.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/themes.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:my_cities_time/page/main_screens/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:my_cities_time/api/api_keys.dart';
import 'package:my_cities_time/models/weather.dart';
import 'package:http/http.dart' as http;
class Travel extends StatefulWidget {
  @override
  _TravelState createState() => _TravelState();
}

class _TravelState extends State<Travel> with SingleTickerProviderStateMixin  {
  TabController tabController;bool loader=false;
  List<mapbox.LatLng> lating=new List<mapbox.LatLng>();
TextEditingController searchcontroller=TextEditingController();
  var uuid= new Uuid();
  List<List<mapbox.LatLng>> final_lating=new  List<List<mapbox.LatLng>>();
  Iterable markers = [];
  final mapbox.LatLng center = const mapbox.LatLng(24.580664, 67.5563837);

  _TravelState();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 1, vsync: this);

    searchcontroller.addListener(() {        _onChanged();    });
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
        Tab(child: Text("Travel Destination",style: TextStyle(color:  Colors.black,fontWeight: FontWeight.w700,fontSize: 15),),),
       // Tab(child: Text("Suntan Roadmap",style: TextStyle(color:  Colors.black,fontWeight: FontWeight.w700,fontSize: 15),),),
      ],
      controller: tabController,
    );
  }    List<CityWeather> weathers=List<CityWeather>();

  List<Weather> searchweather=List<Weather>();
  Future<Weather> getWeatherData(String cityName) async {
     const baseUrl = 'http://api.openweathermap.org';
    final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=4598e3e8b70d175fd36e3963636ea9e1';
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

  String _sessionToken ;
  List<dynamic>_placeList = [];
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
 //    setState(() {
 //      loader = true;
 //    });
 //    Position position = await Geolocator()
 //        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
 //    print(position.longitude);
 // // lating  =mapbox.LatLng(position.latitude, position.longitude);
 //    // await getweather(position);
 //
 //    await (getallweatherdata(
 //        latitude: position.latitude, longitude: position.longitude));
 //    getmarkers();
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
      loader=true;
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
        loader=false;
      });
      throw Exception('Failed to load predictions');
    }
  }
getplaces() async{
    searchweather.clear();
    List result = _placeList.toSet().toList();
for(int i=0;i<result.length;i++){
  Weather w;
  try {
    print(result[i]['structured_formatting']['main_text']);
   w = await (getWeatherData(result[i]['structured_formatting']['main_text'].toString()));
//   if(w==null){
//
//     i++;
//     w = await (getWeatherData(_placeList[i]["description"]));
//
//   }
    setState(() {
      print("rizwan");
if(contains(searchweather, w.cityName)){
  i++;
}
else {
  searchweather.add(w);
}
 //
    });
  }catch(Exception){
    i++;


  }

}
setState(() {
  loader=false;
});

}
  bool contains(List<Weather> element,String cityname) {
    for (Weather e in element) {
      if (e.cityName == cityname) return true;
    }
    return false;
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
                          color:  Colors.black,
                          fontSize: 32,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  _getTabBar(),
                  Center(
                    child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width*0.7,
                        padding: EdgeInsets.only(top:20),
                        child: Theme(
                          data: new ThemeData(
                            primaryColor: fontOrange,

                          ),
                          child: TextField(
                            onChanged: (value) {
if(searchcontroller.text==null||searchcontroller.text.contains("")){

//  setState(() {
//    _placeList.clear();
//    searchweather.clear();
//  });
}
                            },
                            controller: searchcontroller,
                            style: TextStyle(color:Colors.black),
                            decoration: InputDecoration(

                              border: OutlineInputBorder(

                                borderSide: BorderSide(width: 0, style: BorderStyle.solid,color: fontOrange),

                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(25.0),
                                ),
                              ),
                              hintText: 'Search..',
                              fillColor: Colors.white,
                              filled: true,

                              focusColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                            ),
                          ),
                        )
                    ),
                  ),


                  Container(
                    height: MediaQuery.of(context).size.height * 0.55 ,
                    child: _getTabBarView(
                      <Widget>[

                        loader?SpinKitRipple(color:Colors.black,size:40):

                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:List.generate(searchcontroller.text!=null||searchcontroller.text.contains("")?(state.top_three==null?0:state.top_three.length):(searchweather==null?0:searchweather.length<=0?0:searchweather.length),(index){
                              if(index<searchweather.length)
                                return GestureDetector(
                                        onTap: () async {

                                          print("hassan");
                                          setState(() {
                                            searchcontroller.text=_placeList[index]["description"];
//              _placeList.clear();
                                          });
    var addresses = await Geocoder.local.findAddressesFromQuery(searchweather[index].cityName);

    var first = addresses.first;
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => WeatherScreen(lat: first.coordinates.latitude,long: first.coordinates.longitude,)),
    );
                                        },
                                        child: Padding(
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
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Center(
                                                          child: Text("${searchweather[index].cityName}",style: TextStyle(
                                                              color: Colors.black,
                                                              fontFamily: "OpenSans",
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 18
                                                          ),),
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
                                                            Text("${
                                                                double.parse(searchweather[index].temperature.celsius.toString()).floorToDouble().toString()} \u00B0C",style: TextStyle(
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
                                                            Text("${searchweather[index].description}",style: TextStyle(
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
                                                      getIconData(searchweather[index].iconCode),
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
                                                )),
                                          ),
                                        )
                                    );

                              else
                                return   GestureDetector(
                                 onTap: () async {
                                   var addresses = await Geocoder.local.findAddressesFromQuery(state.top_three[index].cityName);

                                   var first = addresses.first;
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) => WeatherScreen(lat: first.coordinates.latitude,long: first.coordinates.longitude,)),
                                   );
                                 },
                                  child: Padding(
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
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Text("${state.top_three[index].cityName}",style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: "OpenSans",
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18
                                                    ),),
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
                                                      Text("${
                                                          double.parse(state.top_three[index].temperature.celsius.toString()).floorToDouble().toString()} \u00B0C",style: TextStyle(
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
                                                      Text("${state.top_three[index].description}",style: TextStyle(
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
                                                        "UVI Index : ",
                                                        style: TextStyle(
                                                            color: fontOrange,
                                                            fontFamily: "OpenSans",
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: 16),
                                                      ),
                                                      Text("${state.top_three[index].uv_value}",style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "OpenSans",
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 16),),
                                                    ],
                                                  ),

                                                ],
                                              ),

                                              Icon(
                                                getIconData(state.top_three[index].iconCode),
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
                                          )),
                                    ),
                                  ),
                                );

                            }),

                          ),
                        ),
                        // SingleChildScrollView(
                        //   child: Column(
                        //     children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(
                        //               left: 12.0, right: 12.0, bottom: 5,top: 15),
                        //           child: Container(
                        //             height: MediaQuery.of(context).size.height * 0.24,
                        //             child:
                        //
                        //             Card(
                        //               color: cardColor,
                        //               elevation: 5,
                        //               shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.only(
                        //                     bottomRight: Radius.circular(15),
                        //                     topRight: Radius.circular(15),
                        //                     topLeft: Radius.circular(15),
                        //                     bottomLeft: Radius.circular(15)),
                        //               ),
                        //               child: loader?SpinKitRipple(color:Colors.black,size:40):
                        //               mapbox.MapboxMap(
                        //                 tiltGesturesEnabled: true,
                        //                 accessToken: 'pk.eyJ1IjoiaGFzc2FucmVobWFuMDEzOTgiLCJhIjoiY2tqY25lcnIyMmFhYTJ6bnl2MGthamZiZyJ9.ZImRGisXPJXqjde9Ltu3tg',
                        //                 onMapCreated: _onMapCreated,
                        //                 onStyleLoadedCallback: () => onStyleLoaded(mapController),
                        //                 initialCameraPosition: mapbox.CameraPosition(
                        //                   target: center,
                        //                   zoom: 0,
                        //                 ),
                        //                 annotationOrder: const [
                        //                   mapbox.AnnotationType.line,
                        //                   mapbox.AnnotationType.symbol,
                        //                   mapbox.AnnotationType.circle,
                        //                   mapbox.AnnotationType.fill,
                        //                 ],
                        //               ),
                        //               //                                     GoogleMap(
                        //               // mapType: MapType.normal,
                        //               // markers:Set.from(
                        //               //   markers,
                        //               // ),
                        //               //
                        //               //                                       initialCameraPosition:
                        //               //                                       CameraPosition(target: lating,  zoom: 0.0),
                        //               //
                        //               // // initialZoom: 20,
                        //               //
                        //               //
                        //               // // onMapCreated: (GoogleMapController controller) {
                        //               // // controller.setMapStyle(MapStyle.retro);
                        //               // // _controller.complete(controller);
                        //               // // },
                        //               // ),
                        //
                        //             ),
                        //           ),
                        //         ),
                        //
                        //       SizedBox(
                        //         height: 5,
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(
                        //             left: 25.0, right: 12.0),
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Text(
                        //               "My Training Records ",
                        //               style: TextStyle(
                        //                   color:  Colors.black,
                        //                   fontFamily: "OpenSans",
                        //                   fontWeight: FontWeight.w700,
                        //                   fontSize: 24),
                        //             ),
                        //
                        //             Container(
                        //               width: double.infinity,
                        //               height: MediaQuery.of(context).size.height*0.3,
                        //
                        //
                        //               child:
                        //
                        //
                        //               SingleChildScrollView(
                        //                 child: Column(
                        //                   children: List.generate(state.all_skin_data==null?0:state.all_skin_data.length,(index){
                        //
                        //                     return  Padding(
                        //                       padding: const EdgeInsets.only(right: 8,left: 8,top:30),
                        //                       child: Column(
                        //                         children: [
                        //                           Row(
                        //                             mainAxisAlignment: MainAxisAlignment.center,
                        //                             crossAxisAlignment: CrossAxisAlignment.center,
                        //                             children: [
                        //                               Text(state.all_skin_data[index].city,style: TextStyle(color:  Colors.black,fontSize: 18,fontFamily: "OpenSans",fontWeight: FontWeight.w700),),
                        //                             ],),
                        //                           SizedBox(height: 10,),
                        //                           Row(
                        //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                             children: [
                        //                               Row(
                        //                                 children: [
                        //                                   Text("Date",style: TextStyle(color:fontOrange,fontSize: 16,fontWeight: FontWeight.w700,fontFamily: "OpenSans"),),
                        //                                   SizedBox(width: 5,),
                        //                                   Text(state.all_skin_data[index].date.substring(0,11),style: TextStyle(color:  Colors.black,fontSize: 16,fontFamily: "OpenSans"),),
                        //                                 ],
                        //                               ),
                        //
                        //                               Row(
                        //                                 children: [
                        //                                   Text("Time",style: TextStyle(color:fontOrange,fontSize: 16,fontWeight: FontWeight.w700,fontFamily: "OpenSans"),),
                        //                                   SizedBox(width: 5,),
                        //                                   Text(state.all_skin_data[index].time,style: TextStyle(color:  Colors.black,fontSize:16,fontFamily: "OpenSans"),),
                        //                                 ],
                        //                               ),
                        //                             ],),
                        //                         ],
                        //                       ),
                        //                     );
                        //                   }),
                        //
                        //                   //
                        //                   // [
                        //                   //  ,
                        //                   //   Card(
                        //                   //     elevation: 0,
                        //                   //
                        //                   //     child: Padding(
                        //                   //       padding: const EdgeInsets.all(8.0),
                        //                   //       child: Column(
                        //                   //         children: [
                        //                   //           Row(
                        //                   //             mainAxisAlignment: MainAxisAlignment.center,
                        //                   //             crossAxisAlignment: CrossAxisAlignment.center,
                        //                   //             children: [
                        //                   //               Text("Barcelona",style: TextStyle(color: Colors.black,fontSize: 20),),
                        //                   //             ],),
                        //                   //           SizedBox(height: 10,),
                        //                   //           Row(
                        //                   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                   //             children: [
                        //                   //               Row(
                        //                   //                 children: [
                        //                   //                   Text("Date",style: TextStyle(color:fontOrange,fontSize: 20,fontWeight: FontWeight.w700),),
                        //                   //                   SizedBox(width: 10,),
                        //                   //                   Text("2019-07-21",style: TextStyle(color: Colors.black,fontSize: 20),),
                        //                   //                 ],
                        //                   //               ),
                        //                   //
                        //                   //               Row(
                        //                   //                 children: [
                        //                   //                   Text("Time",style: TextStyle(color:fontOrange,fontSize: 20,fontWeight: FontWeight.w700),),
                        //                   //                   SizedBox(width: 10,),
                        //                   //                   Text("3 Hours",style: TextStyle(color: Colors.black,fontSize: 20),),
                        //                   //                 ],
                        //                   //               ),
                        //                   //             ],),
                        //                   //         ],
                        //                   //       ),
                        //                   //     ),
                        //                   //   ),
                        //                   //   Card(
                        //                   //     elevation: 0,
                        //                   //
                        //                   //     child: Padding(
                        //                   //       padding: const EdgeInsets.all(8.0),
                        //                   //       child: Column(
                        //                   //         children: [
                        //                   //           Row(
                        //                   //             mainAxisAlignment: MainAxisAlignment.center,
                        //                   //             crossAxisAlignment: CrossAxisAlignment.center,
                        //                   //             children: [
                        //                   //               Text("Barcelona",style: TextStyle(color: Colors.black,fontSize: 20),),
                        //                   //             ],),
                        //                   //           SizedBox(height: 10,),
                        //                   //           Row(
                        //                   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //                   //             children: [
                        //                   //               Row(
                        //                   //                 children: [
                        //                   //                   Text("Date",style: TextStyle(color:fontOrange,fontSize: 20,fontWeight: FontWeight.w700),),
                        //                   //                   SizedBox(width: 10,),
                        //                   //                   Text("2019-07-21",style: TextStyle(color: Colors.black,fontSize: 20),),
                        //                   //                 ],
                        //                   //               ),
                        //                   //
                        //                   //               Row(
                        //                   //                 children: [
                        //                   //                   Text("Time",style: TextStyle(color:fontOrange,fontSize: 20,fontWeight: FontWeight.w700),),
                        //                   //                   SizedBox(width: 10,),
                        //                   //                   Text("3 Hours",style: TextStyle(color: Colors.black,fontSize: 20),),
                        //                   //                 ],
                        //                   //               ),
                        //                   //             ],),
                        //                   //         ],
                        //                   //       ),
                        //                   //     ),
                        //                   //   ),
                        //                   // ],
                        //                 ),
                        //               ),
                        //             ),
                        //
                        //           ],
                        //         ),
                        //       ),
                        //       SizedBox(width: 10),
                        //     ],
                        //   ),
                        // )
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
      mapController.addCircle(
        mapbox.CircleOptions(
          draggable: false,
          circleColor: "#FF0000",
          circleRadius: 5.0,
          circleOpacity: 3,
          geometry: lating[i]
        )
      );
//      mapController.addLine(
//        mapbox.LineOptions(
//          draggable: false,
//          lineColor: "#ff0000",
//          lineWidth: 7.0,
//          lineOpacity: 3,
//          geometry: [
//
//            mapbox.LatLng(
//                lating[i].latitude, lating[i].longitude + 1),
//            mapbox.LatLng(lating[i].latitude, lating[i].longitude),
//            mapbox.LatLng(
//                lating[i].latitude + 1,lating[i].longitude + 1),
//            mapbox.LatLng(
//                lating[i].latitude + 1, lating[i].longitude),
//          ],
//        ),
//      );
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