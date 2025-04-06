import 'dart:convert';

import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/models/hourly_model.dart';

class HourlyRepository {
  final WeatherDataProvider weatherDataProvider;
  HourlyRepository({required this.weatherDataProvider});
  String cityName = "Ho%20Chi%20Minh%20City";
  Future<HourlyModel> getHourlyWeather(int atIndex) async {
    try {
      final data = await weatherDataProvider.getCurrentWeather(cityName);
      return HourlyModel.fromMap(jsonDecode(data), atIndex);
    } catch (e) {
      throw "Something went wrong";
    }
  }
}
