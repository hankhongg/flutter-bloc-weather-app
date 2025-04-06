import 'dart:convert';

import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider weatherDataProvider;
  WeatherRepository({required this.weatherDataProvider});
  String cityName ="Ho%20Chi%20Minh%20City";
  Future<WeatherModel> getCurrentWeather() async {
    try {
      final data = await weatherDataProvider.getCurrentWeather(cityName);
      return WeatherModel.fromMap(jsonDecode(data));
    }
    catch (e) {
      throw "Something went wrong";
    }
  }

}