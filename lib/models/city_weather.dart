import 'package:flutter/material.dart';
import 'package:my_cities_time/utils/WeatherIconMapper.dart';
import 'package:my_cities_time/utils/converters.dart';
class CityWeather {
  int id;
  int sunrise;
  int sunset;
  int humidity;

  String description;
  String iconCode;
  String cityName;

  double windSpeed;

  Temperature temperature;
  Temperature maxTemperature;
  Temperature minTemperature;

  CityWeather(
      {this.id,
      this.sunrise,
      this.sunset,
      this.humidity,
      this.description,
      this.iconCode,
      this.cityName,
      this.windSpeed,
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
     });

  static CityWeather fromJson(Map<String, dynamic> json) {
    final weather = json;
    return CityWeather(
      id: weather['id'],
      description: weather['weather'][0]['description'],
      iconCode: weather['weather'][0]['icon'],
      cityName: weather['name'],
      temperature: Temperature(intToDouble(weather['main']['temp'])),
      maxTemperature: Temperature(intToDouble(weather['main']['temp_max'])),
      minTemperature: Temperature(intToDouble(weather['main']['temp_min'])),
      humidity: weather['main']['humidity'],
      windSpeed: intToDouble(weather['wind']['speed']),
    );
  }


  IconData getIconData(){
    switch(this.iconCode){
      case '01d': return WeatherIcons.clear_day;
      case '01n': return WeatherIcons.clear_night;
      case '02d': return WeatherIcons.few_clouds_day;
      case '02n': return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d': return WeatherIcons.shower_rain_day;
      case '09n': return WeatherIcons.shower_rain_night;
      case '10d': return WeatherIcons.rain_day;
      case '10n': return WeatherIcons.rain_night;
      case '11d': return WeatherIcons.thunder_storm_day;
      case '11n': return WeatherIcons.thunder_storm_night;
      case '13d': return WeatherIcons.snow_day;
      case '13n': return WeatherIcons.snow_night;
      case '50d': return WeatherIcons.mist_day;
      case '50n': return WeatherIcons.mist_night;
      default: return WeatherIcons.clear_day;
    }
  }
}
