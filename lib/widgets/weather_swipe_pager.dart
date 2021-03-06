import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_cities_time/models/weather.dart';
import 'package:my_cities_time/widgets/temperature_line_chart.dart';

import '../main.dart';
import 'current_conditions.dart';
import 'empty_widget.dart';

class WeatherSwipePager extends StatelessWidget {
  const WeatherSwipePager({
    Key key,
    @required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Swiper(
        itemCount: 2,
        index: 0,
        itemBuilder: (context, index) {
          if (index == 0) {

            return
              Column(

                children: [

                  Text(
                    this.weather.description.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        letterSpacing: 5,
                        fontSize: 15,
                        color: AppStateContainer.of(context).theme.accentColor),
                  ),
          CurrentConditions(
          weather: weather,
          )
                ],
              );

          } else if (index == 1) {
            return Column(

              children: [

                Text(
                  "daily peak UV level".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      letterSpacing: 5,
                      fontSize: 15,
                      color: AppStateContainer.of(context).theme.accentColor),
                ),
          Container(
          height: 270,
            child: TemperatureLineChart(
            weather.weatheruv,
            animate: true,
            ),
          )
              ],
            );

          }
          return EmptyWidget();
        },
        pagination: new SwiperPagination(
            margin: new EdgeInsets.all(5.0),
            builder: new DotSwiperPaginationBuilder(
                size: 5,
                activeSize: 5,
                color: AppStateContainer.of(context)
                    .theme
                    .accentColor
                    .withOpacity(0.4),
                activeColor:
                AppStateContainer.of(context).theme.accentColor)),
      ),
    );
  }
}
