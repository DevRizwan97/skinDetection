import 'dart:collection';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
import 'package:charts_flutter/flutter.dart' as charts;

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
//   getchartdata() {
//     setState(() {
//       loader = true;
//     });
//     var state = Provider.of<AuthState>(context, listen: false);
//     List<String> months=List<String>();
// for(int i=0;i<state.all_skin_data.length;i++){
//   months.add(state.all_skin_data[i].month);
//
// }
//     distintmonths = LinkedHashSet<String>.from(months).toList();
//
//     distintmonths.forEach((u) {
//       double sum = 0;
//       int counter=0;
//       for (int i = 0; i < state.all_skin_data.length; i++) {
//         if (u.contains(state.all_skin_data[i].month)) {
//           print(state.all_skin_data[i].skintype);
//           sum += double.parse(state.all_skin_data[i].skintype);
//        counter+=1;
//         }
//       }
//       if(counter!=0){
//       values.add(sum/counter);
//       }
//     });
//     for (int i = 0; i < values.length; i++) {
//       var b = BarChartGroupData(
//         x: i,
//         barRods: [BarChartRodData(y: values[i], color: chartcolor)],
//         //showingTooltipIndicators: [0],
//       );
//       setState(() {
//         barchartdata.add(b);
//       });
//     }
//     setState(() {
//       loader = false;
//     });
//   }
  List<charts.Series<SkinGraph, String>> _createchartData() {
    var state = Provider.of<AuthState>(context, listen: false);
    List<SkinGraph> data = List<SkinGraph>();
    for (int i = 0; i < state.all_skin_data.length; i++) {
      print(
          int.parse(state.all_skin_data[i].skintype));
      data.add(new SkinGraph(
          state.all_skin_data[i].month,
          int.parse(state.all_skin_data[i].skintype),
          state.all_skin_data[i].skincolor));
    }

    return [
      new charts.Series<SkinGraph, String>(
        id: 'Skintone',
        displayName: "Month",

        colorFn: (SkinGraph graph, _) =>
            charts.Color.transparent,
        domainFn: (SkinGraph graph, _) => graph.month.toUpperCase(),
        measureFn: (SkinGraph graph, _) => graph.type,
        data: data,

      ),
      new charts.Series<SkinGraph, String>(
        id: 'Skintone',
        displayName: "Month",

        colorFn: (SkinGraph graph, _) =>
            charts.Color.fromHex(code: graph.skincolorcode),
        domainFn: (SkinGraph graph, _) => graph.month.toUpperCase(),
        measureFn: (SkinGraph graph, _) => graph.type,
        data: data,

      ),   new charts.Series<SkinGraph, String>(
        id: 'Skintone',
        displayName: "Month",

        colorFn: (SkinGraph graph, _) =>
            charts.Color.transparent,
        domainFn: (SkinGraph graph, _) => graph.month.toUpperCase(),
        measureFn: (SkinGraph graph, _) => graph.type,
        data: data,

      ),
    ];
  }

// class OrdinalSales {
//   final String year;
//   final int sales;
//
//   OrdinalSales(this.year, this.sales);
// }
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
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: SingleChildScrollView(
              //physics: NeverScrollableScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Skin Tracker",
                        style: TextStyle(
                            color: Colors.black,
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
                              child: new charts.BarChart(
                                _createchartData(),
                                animate: true,
                                defaultRenderer: new charts.BarRendererConfig(
                                    cornerStrategy: const charts.ConstCornerStrategy(0)),

                              ),

                              // BarChart(
                              //   BarChartData(
                              //       alignment: BarChartAlignment.spaceAround,
                              //       maxY: 20,
                              //       barTouchData: BarTouchData(
                              //         enabled: true,
                              //         touchTooltipData: BarTouchTooltipData(
                              //           tooltipBgColor: chartpointcolor,
                              //           getTooltipItem: (
                              //             BarChartGroupData group,
                              //             int groupIndex,
                              //             BarChartRodData rod,
                              //             int rodIndex,
                              //           ) {
                              //             return BarTooltipItem(
                              //               " ",
                              //               TextStyle(
                              //                 color: Colors.white,
                              //                 fontWeight: FontWeight.bold,
                              //               ),
                              //             );
                              //           },
                              //         ),
                              //       ),
                              //       axisTitleData: FlAxisTitleData(
                              //         show: true,
                              //         bottomTitle: AxisTitle(
                              //             showTitle: true,
                              //             titleText: "Month",
                              //             textStyle: TextStyle(
                              //                 color:  Colors.black,
                              //                 fontWeight: FontWeight.bold)),
                              //         leftTitle: AxisTitle(
                              //             showTitle: true,
                              //             titleText: "Skin type",
                              //             textStyle: TextStyle(
                              //                 color:  Colors.black,
                              //                 fontWeight: FontWeight.bold)),
                              //       ),
                              //       gridData: FlGridData(
                              //         show: false,
                              //       ),
                              //       titlesData: FlTitlesData(
                              //         show: true,
                              //         bottomTitles: SideTitles(
                              //           showTitles: true,
                              //           textStyle: const TextStyle(
                              //               color: Color(0xff7589a2),
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 14),
                              //           margin: 20,
                              //           getTitles: (double value) {
                              //             for (int i = 0;
                              //                 i < distintmonths.length;
                              //                 i++) {
                              //               return distintmonths[i].toUpperCase();
                              //             }
                              //
                              //           },
                              //         ),
                              //         leftTitles: SideTitles(
                              //           interval: 5,
                              //           showTitles: true,
                              //           textStyle: const TextStyle(
                              //               color: Color(0xff7589a2),
                              //               fontWeight: FontWeight.bold,
                              //               fontSize: 14),
                              //           // margin: 32,
                              //           // reservedSize: 14,
                              //           getTitles: (value) {
                              //             if (value == 1) {
                              //               return '1';
                              //             } else if (value == 2) {
                              //               return '2';
                              //             } else if (value == 3) {
                              //               return '3';
                              //             } else if (value == 4) {
                              //               return '4';
                              //             } else if (value == 5) {
                              //               return '5';
                              //             } else if (value == 6) {
                              //               return '6';
                              //             }
                              //             else if (value == 7) {
                              //               return '7';
                              //             }
                              //             else if (value == 8) {
                              //               return '8';
                              //             }
                              //             else if (value == 9) {
                              //               return '9';
                              //             }
                              //             else if (value == 10) {
                              //               return '10';
                              //             }
                              //           },
                              //         ),
                              //       ),
                              //       borderData: FlBorderData(
                              //         show: true,
                              //       ),
                              //       barGroups: barchartdata
                              //
                              //       // [
                              //       //
                              //       //   BarChartGroupData(
                              //       //
                              //       //     x: 0,
                              //       //     barRods: [
                              //       //       BarChartRodData(y: 8, color:chartcolor)
                              //       //     ],
                              //       //     showingTooltipIndicators: [0],
                              //       //   ),
                              //       //   BarChartGroupData(
                              //       //     x: 1,
                              //       //     barRods: [
                              //       //       BarChartRodData(y: 10, color:chartcolor)
                              //       //     ],
                              //       //     showingTooltipIndicators: [0],
                              //       //   ),
                              //       //   BarChartGroupData(
                              //       //     x: 2,
                              //       //     barRods: [
                              //       //       BarChartRodData(y: 14, color:chartcolor)
                              //       //     ],
                              //       //     showingTooltipIndicators: [0],
                              //       //   ),
                              //       //   BarChartGroupData(
                              //       //     x: 3,
                              //       //     barRods: [
                              //       //       BarChartRodData(y: 15, color:chartcolor)
                              //       //     ],
                              //       //     showingTooltipIndicators: [0],
                              //       //   ),
                              //       //   BarChartGroupData(
                              //       //     x: 3,
                              //       //     barRods: [
                              //       //       BarChartRodData(y: 13, color:chartcolor)
                              //       //     ],
                              //       //     showingTooltipIndicators: [0],
                              //       //   ),
                              //       //   BarChartGroupData(
                              //       //     x: 3,
                              //       //     barRods: [
                              //       //       BarChartRodData(y: 10, color:chartcolor)
                              //       //     ],
                              //
                              //
                              //
                              //
                              //
                              //
                              //
                              //
                              //
                              //
                              //       //     showingTooltipIndicators: [0],
                              //       //   ),
                              //       // ],
                              //       ),
                              // ),
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
                                color: Colors.black,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w700,
                                fontSize: 24),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Date",
                                                style: TextStyle(
                                                    color: Colors.black,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Location",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w700,
                                                      fontFamily: "OpenSans"),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Skin Color",
                                                style: TextStyle(
                                                    color: Colors.black,
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
                          ),
                          Column(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              
                                state.all_skin_data == null
                                    ? 0
                                    : state.all_skin_data.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, left: 8, top: 30),
                                child: SingleChildScrollView( 
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                state
                                                    .all_skin_data[index].date
                                                    .substring(0, 11),
                                                style: TextStyle(
                                                    color: Colors.black,
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
                                                    color: Colors.black,
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
                                                    color: state.all_skin_data ==
                                                            null
                                                        ? Colors.transparent
                                                        : Color(int.parse(state
                                                            .all_skin_data[
                                                                index]
                                                            .skincolor
                                                            .replaceAll('#',
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
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/material.dart';
//
// class SkinTracker extends StatelessWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;
//
//   SkinTracker(this.seriesList, {this.animate});
//
//   /// Creates a [BarChart] with sample data and no transition.
//   factory SkinTracker.withSampleData() {
//     return new SkinTracker(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return new charts.BarChart(
//       seriesList,
//       animate: animate,
//     );
//   }
//
//   /// Create one series with sample hard coded data.
//   static List<charts.Series<OrdinalSales, String>> _createSampleData() {
//     final data = [
//       new OrdinalSales('2014', 5),
//       new OrdinalSales('2015', 25),
//       new OrdinalSales('2016', 100),
//       new OrdinalSales('2017', 75),
//     ];
//
//     return [
//       new charts.Series<OrdinalSales, String>(
//         id: 'Sales',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         data: data,
//       )
//     ];
//   }
// }
//
// /// Sample ordinal data type.
class SkinGraph {
  final String month;
  final int type;
  final String skincolorcode;

  SkinGraph(this.month, this.type, this.skincolorcode);
}
