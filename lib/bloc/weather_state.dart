
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:my_cities_time/models/weather.dart';

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({@required this.weather})
      : assert(weather != null),
        super([weather]);
}

class WeatherError extends WeatherState {
  final int errorCode;

  WeatherError({@required this.errorCode})
      : assert(errorCode != null),
        super([errorCode]);
}
