// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

String convertToC(double k){
    return (k - 273.15).toStringAsFixed(2);
  }

class HourlyModel {
  //  time: DateFormat.jm().format(DateTime.parse(hourlyForecast['dt_txt'])),
  //                       temp: double.parse(convertToC(hourlyForecast['main']['temp'])), 
  //                       icon: hourlyForecast['weather'][0]['main'] == 'Clouds' ? Icons.cloud : currStatus == 'Rain' ? Icons.thunderstorm : Icons.sunny,
                      
  final String time;
  final double temp;
  final String iconName;
  HourlyModel({
    required this.time,
    required this.temp,
    required this.iconName,
  });

  HourlyModel copyWith({
    String? time,
    double? temp,
    String? iconName,
  }) {
    return HourlyModel(
      time: time ?? this.time,
      temp: temp ?? this.temp,
      iconName: iconName ?? this.iconName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'temp': temp,
      'iconName': iconName,
    };
  }

  factory HourlyModel.fromMap(Map<String, dynamic> map, int atIndex) {
    final hourlyForecast = map['list'][atIndex];
    return HourlyModel(
      time: DateFormat.jm().format(DateTime.parse(hourlyForecast['dt_txt'])),
      temp: double.parse(convertToC(hourlyForecast['main']['temp'])),
      iconName: hourlyForecast['weather'][0]['main']
    );
  }

  String toJson() => json.encode(toMap());

  factory HourlyModel.fromJson(String source, int atIndex) => HourlyModel.fromMap(json.decode(source) as Map<String, dynamic>, atIndex);

  @override
  String toString() => 'HourlyModel(time: $time, temp: $temp, iconName: $iconName)';

  @override
  bool operator ==(covariant HourlyModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.time == time &&
      other.temp == temp &&
      other.iconName == iconName;
  }

  @override
  int get hashCode => time.hashCode ^ temp.hashCode ^ iconName.hashCode;
}
