import 'dart:collection';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:my_cities_time/main.dart';
import 'package:my_cities_time/models/skin.dart';
import 'package:my_cities_time/widgets/DrawerWidget.dart';
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
                                    cornerStrategy:
                                        const charts.ConstCornerStrategy(0)),
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
                                                      fontWeight:
                                                          FontWeight.w700,
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
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                                state.all_skin_data[index].date
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
                                                state.all_skin_data[index].city,
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
                                                  decoration: new BoxDecoration(
                                                    color: state.all_skin_data ==
                                                            null
                                                        ? Colors.transparent
                                                        : Color(int.parse(state
                                                            .all_skin_data[
                                                                index]
                                                            .skincolor
                                                            .replaceAll(
                                                                '#', '0xff'))),
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
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ));
  }

  //This function will get all data of skin of user and will link that data to SKinGraph model
  List<charts.Series<SkinGraph, String>> _createchartData() {
    var state = Provider.of<AuthState>(context, listen: false);
    List<SkinGraph> data = List<SkinGraph>();

    for (int i = 0; i < state.all_skin_data.length; i++) {
      data.add(new SkinGraph(
          state.all_skin_data[i].month,
          int.parse(state.all_skin_data[i].skintype),
          state.all_skin_data[i].skincolor));
    }

    return [
      new charts.Series<SkinGraph, String>(
        id: 'Skintone',
        displayName: "Month",
        colorFn: (SkinGraph graph, _) => charts.Color.transparent,
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
      ),
      new charts.Series<SkinGraph, String>(
        id: 'Skintone',
        displayName: "Month",
        colorFn: (SkinGraph graph, _) => charts.Color.transparent,
        domainFn: (SkinGraph graph, _) => graph.month.toUpperCase(),
        measureFn: (SkinGraph graph, _) => graph.type,
        data: data,
      ),
    ];
  }
}

class SkinGraph {
  final String month;
  final int type;
  final String skincolorcode;

  SkinGraph(this.month, this.type, this.skincolorcode);
}
