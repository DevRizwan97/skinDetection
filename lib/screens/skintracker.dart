// import 'dart:convert';
// import 'dart:isolate';
// import 'dart:math';
//
// import 'package:android_alarm_manager/android_alarm_manager.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:my_cities_time/api/api_keys.dart';
// import 'package:my_cities_time/api/http_exception.dart';
// import 'package:my_cities_time/api/weather_api_client.dart';
// import 'package:my_cities_time/bloc/weather_bloc.dart';
// import 'package:my_cities_time/bloc/weather_event.dart';
// import 'package:my_cities_time/bloc/weather_state.dart';
// import 'package:my_cities_time/flutter_datetime_picker.dart';
// import 'package:my_cities_time/models/weather.dart' as weather;
// import 'package:my_cities_time/repository/weather_repository.dart';
// import 'package:my_cities_time/shared/widgets/DrawerWidget.dart';
// import 'package:my_cities_time/screens/Travel.dart';
// import 'package:my_cities_time/screens/blog.dart';
// import 'package:my_cities_time/screens/the_protection_shop.dart';
// import 'package:my_cities_time/screens/the_skin_lab.dart';
// import 'package:my_cities_time/screens/weather_screen.dart';
// import 'package:my_cities_time/states/authstate.dart';
// import 'package:my_cities_time/utils/WeatherIconMapper.dart';
// import 'package:my_cities_time/utils/constants.dart';
// import 'package:my_cities_time/widgets/weather_widget.dart';
// import 'package:numberpicker/numberpicker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:weather/weather.dart';
//
// import '../main.dart';
//
// class SkinTracker extends StatefulWidget {
//   final WeatherRepository weatherRepository = WeatherRepository(
//       weatherApiClient: WeatherApiClient(
//           httpClient: http.Client(), apiKey: ApiKey.OPEN_WEATHER_MAP));
//
//   @override
//   _SkinTrackerState createState() => _SkinTrackerState();
// }
//
// class _SkinTrackerState extends State<SkinTracker> {
//   bool loader = false;
//
//
//   bool showAvg = false;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
//     // _fetchWeatherWithLocation().catchError((error) {
//     //   // _fetchWeatherWithCity();
//     // });
//   }
//   List<Color> gradientColors = [
//  fontOrange,
//     fontOrange ];
//   @override
//   Widget build(BuildContext context) {
//     var state = Provider.of<AuthState>(context, listen: false);
//
//     return Stack(
//       children: <Widget>[
//         AspectRatio(
//           aspectRatio: 1.70,
//           child: Container(
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(18),
//                 ),
//                 color: Color(0xff232d37)),
//             child: Padding(
//               padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
//               child: LineChart( mainData(),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 60,
//           height: 34,
//           child: FlatButton(
//             onPressed: () {
//               setState(() {
//                 showAvg = !showAvg;
//               });
//             },
//             child: Text(
//               'avg',
//               style: TextStyle(
//                   fontSize: 12, color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
//             ),
//           ),
//         ),
//       ],
//     );;
//   }
//   LineChartData mainData() {
//     return LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//         getDrawingVerticalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 22,
//           textStyle:
//           const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
//           getTitles: (value) {
//             switch (value.toInt()) {
//               case 2:
//                 return 'MAR';
//               case 5:
//                 return 'JUN';
//               case 8:
//                 return 'SEP';
//             }
//             return '';
//           },
//           margin: 8,
//         ),
//         leftTitles: SideTitles(
//           showTitles: true,
//
//             textStyle: const TextStyle(
//             color: Color(0xff67727d),
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//           ),
//           getTitles: (value) {
//             switch (value.toInt()) {
//               case 1:
//                 return '10k';
//               case 3:
//                 return '30k';
//               case 5:
//                 return '50k';
//             }
//             return '';
//           },
//           reservedSize: 28,
//           margin: 12,
//         ),
//       ),
//       borderData:
//       FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
//       minX: 0,
//       maxX: 11,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: [
//             FlSpot(0, 3),
//             FlSpot(2.6, 2),
//             FlSpot(4.9, 5),
//             FlSpot(6.8, 3.1),
//             FlSpot(8, 4),
//             FlSpot(9.5, 3),
//             FlSpot(11, 4),
//           ],
//           isCurved: true,
//           colors: gradientColors,
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   LineChartData avgData() {
//     return LineChartData(
//       lineTouchData: LineTouchData(enabled: false),
//       gridData: FlGridData(
//         show: true,
//         drawHorizontalLine: true,
//         getDrawingVerticalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: const Color(0xff37434d),
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         bottomTitles: SideTitles(
//           showTitles: true,
//           reservedSize: 22,
//           textStyle:
//           const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
//           getTitles: (value) {
//             switch (value.toInt()) {
//               case 2:
//                 return 'MAR';
//               case 5:
//                 return 'JUN';
//               case 8:
//                 return 'SEP';
//             }
//             return '';
//           },
//           margin: 8,
//         ),
//         leftTitles: SideTitles(
//           showTitles: true,
//           textStyle: const TextStyle(
//             color: Color(0xff67727d),
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//           ),
//           getTitles: (value) {
//             switch (value.toInt()) {
//               case 1:
//                 return '10k';
//               case 3:
//                 return '30k';
//               case 5:
//                 return '50k';
//             }
//             return '';
//           },
//           reservedSize: 28,
//           margin: 12,
//         ),
//       ),
//       borderData:
//       FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
//       minX: 0,
//       maxX: 11,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: [
//             FlSpot(0, 3.44),
//             FlSpot(2.6, 3.44),
//             FlSpot(4.9, 3.44),
//             FlSpot(6.8, 3.44),
//             FlSpot(8, 3.44),
//             FlSpot(9.5, 3.44),
//             FlSpot(11, 3.44),
//           ],
//           isCurved: true,
//           colors: [
//             ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
//             ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
//           ],
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(show: true, colors: [
//             ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
//             ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
//           ]),
//         ),
//       ],
//     );
//   }
//
//
//
// }
import 'dart:collection';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:my_cities_time/main.dart';
import 'package:my_cities_time/models/skin.dart';
import 'package:my_cities_time/shared/widgets/DrawerWidget.dart';
import 'package:my_cities_time/states/authstate.dart';
import 'package:my_cities_time/themes.dart';
import 'package:my_cities_time/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:queries/collections.dart';

class SkinTracker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SkinTrackerState();
}

class SkinTrackerState extends State<SkinTracker> {
  List<BarChartGroupData> barchartdata = List<BarChartGroupData>();
  List<String> distintmonths = List<String>();
  List<Skin> newdate = List<Skin>();
  List<double> values = List<double>();
  bool loader = false;

  // List<BarChartGroupData> distintbarchartdata=List<BarChartGroupData>();
  getchartdata() {
    setState(() {
      loader = true;
    });
    var state = Provider.of<AuthState>(context, listen: false);
    List<String> months=List<String>();
for(int i=0;i<state.all_skin_data.length;i++){
  months.add(state.all_skin_data[i].month);

}
    distintmonths = LinkedHashSet<String>.from(months).toList();
;
    distintmonths.forEach((u) {
      double sum = 0;
      int counter=0;
      for (int i = 0; i < state.all_skin_data.length; i++) {
        if (u.contains(state.all_skin_data[i].month)) {
          sum += double.parse(state.all_skin_data[i].skintype);
       counter+=1;
        }
      }
      if(counter!=0){
      values.add(sum/counter);
      }
    });
    for (int i = 0; i < values.length; i++) {
      var b = BarChartGroupData(
        x: i,
        barRods: [BarChartRodData(y: values[i], color: chartcolor)],
        //showingTooltipIndicators: [0],
      );
      setState(() {
        barchartdata.add(b);
      });
    }
    setState(() {
      loader = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getchartdata();
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
              image:AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE?AssetImage("assets/images/nightmode.jpg"): AssetImage("assets/images/bggg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Skin Tracker",
                        style: TextStyle(
                            color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE? Colors.white : Colors.black,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 1.7,
                      child: loader
                          ? SpinKitRipple(color: fontOrange, size: 400)
                          : Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              color: Colors.transparent,
                              child: BarChart(
                                BarChartData(
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: 20,
                                    barTouchData: BarTouchData(
                                      enabled: true,
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipBgColor: chartpointcolor,
                                        tooltipBottomMargin: 5,
                                        tooltipRoundedRadius: 30,
                                        getTooltipItem: (
                                          BarChartGroupData group,
                                          int groupIndex,
                                          BarChartRodData rod,
                                          int rodIndex,
                                        ) {
                                          return BarTooltipItem(
                                            " ",
                                            TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    axisTitleData: FlAxisTitleData(
                                      show: true,
                                      bottomTitle: AxisTitle(
                                          showTitle: true,
                                          titleText: "Month",
                                          textStyle: TextStyle(
                                              color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE? Colors.white : Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      leftTitle: AxisTitle(
                                          showTitle: true,
                                          titleText: "Skin type",
                                          textStyle: TextStyle(
                                              color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE? Colors.white : Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    gridData: FlGridData(
                                      show: true,
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,
                                      bottomTitles: SideTitles(
                                        showTitles: true,
                                        textStyle: const TextStyle(
                                            color: Color(0xff7589a2),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                        margin: 20,
                                        getTitles: (double value) {
                                          for (int i = 0;
                                              i < distintmonths.length;
                                              i++) {
                                            // List months = [
                                            //   'Jan',
                                            //   'Feb',
                                            //   'Mar',
                                            //   'Apr',
                                            //   'May',
                                            //   'Jun',
                                            //   'Jul',
                                            //   'Aug',
                                            //   'Sep',
                                            //   'Oct',
                                            //   'Nov',
                                            //   'Dec'
                                            // ];
                                            // var formatter =
                                            //     new DateFormat('yyyy-MM-dd');
                                            // var date = DateTime.parse(
                                            //     state.all_skin_data[i].date);
                                            // String formattedDate =
                                            //     formatter.format(date);
                                            return distintmonths[i];
                                          }
                                          // switch (value.toInt()) {
                                          //
                                          //   case 0:
                                          //     return 'Mn';
                                          //   case 1:
                                          //     return 'Te';
                                          //   case 2:
                                          //     return 'Wd';
                                          //   case 3:
                                          //     return 'Tu';
                                          //   case 4:
                                          //     return 'Fr';
                                          //   case 5:
                                          //     return 'St';
                                          //   case 6:
                                          //     return 'Sn';
                                          //   default:
                                          //     return '';
                                          //  }
                                        },
                                      ),
                                      leftTitles: SideTitles(
                                        interval: 5,
                                        showTitles: true,
                                        textStyle: const TextStyle(
                                            color: Color(0xff7589a2),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                        // margin: 32,
                                        // reservedSize: 14,
                                        getTitles: (value) {
                                          if (value == 0) {
                                            return '1';
                                          } else if (value == 5) {
                                            return '2';
                                          } else if (value == 10) {
                                            return '3';
                                          } else if (value == 15) {
                                            return '4';
                                          } else if (value == 20) {
                                            return '5';
                                          } else if (value == 25) {
                                            return '6';
                                          }
                                        },
                                      ),
                                    ),
                                    borderData: FlBorderData(
                                      show: true,
                                    ),
                                    barGroups: barchartdata

                                    // [
                                    //
                                    //   BarChartGroupData(
                                    //
                                    //     x: 0,
                                    //     barRods: [
                                    //       BarChartRodData(y: 8, color:chartcolor)
                                    //     ],
                                    //     showingTooltipIndicators: [0],
                                    //   ),
                                    //   BarChartGroupData(
                                    //     x: 1,
                                    //     barRods: [
                                    //       BarChartRodData(y: 10, color:chartcolor)
                                    //     ],
                                    //     showingTooltipIndicators: [0],
                                    //   ),
                                    //   BarChartGroupData(
                                    //     x: 2,
                                    //     barRods: [
                                    //       BarChartRodData(y: 14, color:chartcolor)
                                    //     ],
                                    //     showingTooltipIndicators: [0],
                                    //   ),
                                    //   BarChartGroupData(
                                    //     x: 3,
                                    //     barRods: [
                                    //       BarChartRodData(y: 15, color:chartcolor)
                                    //     ],
                                    //     showingTooltipIndicators: [0],
                                    //   ),
                                    //   BarChartGroupData(
                                    //     x: 3,
                                    //     barRods: [
                                    //       BarChartRodData(y: 13, color:chartcolor)
                                    //     ],
                                    //     showingTooltipIndicators: [0],
                                    //   ),
                                    //   BarChartGroupData(
                                    //     x: 3,
                                    //     barRods: [
                                    //       BarChartRodData(y: 10, color:chartcolor)
                                    //     ],
                                    //     showingTooltipIndicators: [0],
                                    //   ),
                                    // ],
                                    ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Track your tanning process",
                            style: TextStyle(
                                color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE? Colors.white : Colors.black,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, left: 8, top: 30),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Date",
                                              style: TextStyle(
                                                  color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE? Colors.white : Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "OpenSans"),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Location",
                                              style: TextStyle(
                                                  color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE? Colors.white : Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "OpenSans"),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Skin Color",
                                              style: TextStyle(
                                                  color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE? Colors.white : Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "OpenSans"),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],

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
                            //                   Text("Date",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
                            //                   SizedBox(width: 10,),
                            //                   Text("2019-07-21",style: TextStyle(color: Colors.black,fontSize: 20),),
                            //                 ],
                            //               ),
                            //
                            //               Row(
                            //                 children: [
                            //                   Text("Time",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
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
                            //                   Text("Date",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
                            //                   SizedBox(width: 10,),
                            //                   Text("2019-07-21",style: TextStyle(color: Colors.black,fontSize: 20),),
                            //                 ],
                            //               ),
                            //
                            //               Row(
                            //                 children: [
                            //                   Text("Time",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.w700),),
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
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                      state.all_skin_data == null
                                          ? 0
                                          : state.all_skin_data.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, left: 8, top: 30),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    state
                                                        .all_skin_data[index].date
                                                        .substring(0, 11),
                                                    style: TextStyle(
                                                        color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE? Colors.white : Colors.black,
                                                        fontSize: 16,
                                                        fontFamily: "OpenSans"),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    state.all_skin_data[index]
                                                        .city,
                                                    style: TextStyle(
                                                        color: AppStateContainer.of(context).themeCode==Themes.DARK_THEME_CODE? Colors.white : Colors.black,
                                                        fontSize: 16,
                                                        fontFamily: "OpenSans"),
                                                  ),
                                                  SizedBox(
                                                    width: 23,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 40.0,
                                                    height: 20.0,
                                                    child: Container(
                                                      decoration:
                                                          new BoxDecoration(
                                                        color: state.skin == null
                                                            ? Colors.transparent
                                                            : Color(int.parse(
                                                                state.skin
                                                                    .skincolor
                                                                    .replaceAll(
                                                                        '#',
                                                                        '0xff'))),
                                                        shape: BoxShape.rectangle,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 23,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
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
                  ]),
            ),
          ),
        ));
  }
}

/*

    */
