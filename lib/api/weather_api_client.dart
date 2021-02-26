import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:my_cities_time/api/http_exception.dart';
import 'package:my_cities_time/models/weather.dart';

/// Wrapper around the open weather map api
/// https://openweathermap.org/current
class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  final apiKey;
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient, this.apiKey})
      : assert(httpClient != null),
        assert(apiKey != null);

  Future<String> getCityNameFromLocation(
      {double latitude, double longitude}) async {
    final url =
        '$baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey';
    print('fetching $url');
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return weatherJson['name'];
  }

  Future<Weather> getWeatherData(String cityName) async {
    final url = '$baseUrl/data/2.5/weather?q=$cityName&appid=$apiKey';
    print('fetching $url');
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }

  Future<List<Weather>> getForecast(String cityName,double lat,double long) async {
    //http://api.openweathermap.org/data/2.5/onecall?lat=37.4219927&lon=-122.084035&exclude=minutely,current,daily,alerts&appid=4598e3e8b70d175fd36e3963636ea9e1
//    final url = '$baseUrl/data/2.5/forecast?q=$cityName&appid=$apiKey';

    final url =
        '$baseUrl/data/2.5/onecall?lat=$lat&lon=$long&exclude=minutely,current,daily,alerts&appid=$apiKey';
    print('fetching $url');
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final forecastJson = json.decode(res.body);
    List<Weather> weathers = Weather.fromForecastJson(forecastJson);
    return weathers;
  }
  Future<List<Weather>> getUvForecast(String cityName,double lat,double long) async {
    //http://api.openweathermap.org/data/2.5/onecall?lat=37.4219927&lon=-122.084035&exclude=minutely,current,daily,alerts&appid=4598e3e8b70d175fd36e3963636ea9e1
//    final url = '$baseUrl/data/2.5/forecast?q=$cityName&appid=$apiKey';
//http://api.openweathermap.org/data/2.5/uvi/forecast?lat={lat}&lon={lon}&cnt={cnt}&appid={API key}
    final url =
          '$baseUrl/data/2.5/onecall?lat=$lat&lon=$long&appid=$apiKey&exclude=hourly,alerts,minutely,current';
    print('fetching $url');
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final forecastJson = json.decode(res.body);

    List<Weather> weathers = Weather.fromForecastUvJson(forecastJson);
    return weathers;
  }
  Future<String> onecallweatherdata(
      {double latitude, double longitude}) async {
    final url =
        '$baseUrl/data/2.5/onecall?lat=$latitude&lon=$longitude&appid=$apiKey';
    print('fetching $url');
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return weatherJson['current'];
  }
}
