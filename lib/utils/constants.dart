import 'package:flutter/material.dart';

import 'WeatherIconMapper.dart';




final white = Colors.white;
final fontOrange = Color(0xffF6A545);
final cardColor = Color(0xffFEF9F4);
final black = Color(0xff0b0b0b);
final error=Color(0xffff3333);

final chartcolor=Color(0xffe1ab96);

final chartpointcolor=Color(0xfffea832);

final String api_url="http://165.22.230.126/skin-detect";
 const SHARED_PREF_KEY_THEME = "theme_code";
const SHARED_PREF_KEY_TEMPERATURE_UNIT = "temp_unit";

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