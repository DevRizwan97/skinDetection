import 'package:flutter/material.dart';
import 'package:my_cities_time/utils/WeatherIconMapper.dart';
import 'package:my_cities_time/utils/converters.dart';
class Weather {
  int id;
  int time;
  int sunrise;
  int sunset;
  int humidity;

  String description;
  String iconCode;
  String main;
  String cityName;

  double windSpeed;

  Temperature temperature;
  Temperature feelsLike;
  Temperature maxTemperature;
  Temperature minTemperature;
int uv_value;
int uv_date;
  List<Weather> forecast;
  List<Weather> weatheruv;

  Weather(
      {this.id,
      this.time,
      this.sunrise,
      this.sunset,
      this.humidity,
      this.description,
      this.iconCode,
      this.main,
      this.cityName,
      this.windSpeed,
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
        this.uv_date,
        this.uv_value,
        this.weatheruv,
        this.feelsLike,
      this.forecast});

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: Temperature(intToDouble(json['main']['temp'])),
    feelsLike: Temperature(intToDouble(json['main']['feels_like'])),
      maxTemperature: Temperature(intToDouble(json['main']['temp_max'])),
      minTemperature: Temperature(intToDouble(json['main']['temp_min'])),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: json['main']['humidity'],
      windSpeed: intToDouble(json['wind']['speed']),
    );
  }
  static Weather fromJsoncountry(Map<String, dynamic> json,String name) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: name,
      temperature: Temperature(intToDouble(json['temp'])),
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      humidity: json['humidity'],
      windSpeed: intToDouble(json['wind_speed']),
      uv_value: int.parse(double.parse(json['uvi'].toString()).floor().toString()),
    );
  }
  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = List<Weather>();
    for (final item in json['hourly']) {
      weathers.add(Weather(
          time: item['dt'],
          temperature: Temperature(intToDouble(
            item['temp'],
          )),
          uv_value: int.parse(double.parse(item['uvi'].toString()).floor().toString()),
          iconCode: item['weather'][0]['icon']
      ));
    print("hsan");
    print(item['dt']);
    print( int.parse(double.parse(item['uvi'].toString()).floor().toString()));
    }

    print(weathers);
    return weathers;
  }
  static List<Weather> fromForecastUvJson(Map<String, dynamic> json) {

    final weathers = List<Weather>();
//    myModels=(json.decode(json) as List).map((i) =>
//        Weather.fromJson(i)).toList();
    for (final item in json["daily"]) {
      weathers.add(Weather(
       uv_value:int.parse(double.parse(item['uvi'].toString()).floor().toString()),
        uv_date: int.parse(item["dt"].toString())
      ));

    }
    print(weathers);
    return weathers;
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
