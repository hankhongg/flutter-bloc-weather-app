part of "weather_bloc.dart";

abstract class WeatherState{}

final class WeatherInitial extends WeatherState{}

final class WeatherSuccess extends WeatherState{
  WeatherModel weatherModel;
  HourlyModel hourlyModel;
  WeatherSuccess(this.weatherModel, this.hourlyModel);
}

final class WeatherError extends WeatherState{
  final String errorMessage;
  WeatherError(this.errorMessage);
}

final class WeatherLoading extends WeatherState{}
