
import 'package:meta/meta.dart';
import 'package:my_cities_time/api/weather_api_client.dart';
import 'package:my_cities_time/models/weather.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;
  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String cityName,
      {double latitude, double longitude}) async {
    if (cityName == null) {
      cityName = await weatherApiClient.getCityNameFromLocation(
          latitude: latitude, longitude: longitude);
    }
    var weather = await weatherApiClient.getWeatherData(cityName);
    var weathers = await weatherApiClient.getForecast(cityName,latitude,longitude);

    var uv_weathers = await weatherApiClient.getUvForecast(cityName,latitude,longitude);
    weather.weatheruv=uv_weathers;
    for(int i=0;i<weather.weatheruv.length;i++) {
      print("hassan");
      print(  DateTime.fromMillisecondsSinceEpoch(
          weather.weatheruv[i].uv_date * 1000));
      print( weather.weatheruv[i].uv_value);
    }
    weather.forecast = weathers;
    return weather;
  }
}
