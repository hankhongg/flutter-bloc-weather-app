part of "weather_bloc.dart";

abstract class WeatherEvent{}

class WeatherFetched extends WeatherEvent{
  int atIndex = 0;
  WeatherFetched(this.atIndex);
}
