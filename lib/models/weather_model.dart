// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {


  final double currTemp;
  final String currStatus; // Clouds or Rain or Sunny?
  final int currHumidity;
  final double currWindSpeed;
  final int currPressure;
  WeatherModel({
    required this.currTemp,
    required this.currStatus,
    required this.currHumidity,
    required this.currWindSpeed,
    required this.currPressure,
  });

  WeatherModel copyWith({
    double? currTemp,
    String? currStatus,
    int? currHumidity,
    double? currWindSpeed,
    int? currPressure,
  }) {
    return WeatherModel(
      currTemp: currTemp ?? this.currTemp,
      currStatus: currStatus ?? this.currStatus,
      currHumidity: currHumidity ?? this.currHumidity,
      currWindSpeed: currWindSpeed ?? this.currWindSpeed,
      currPressure: currPressure ?? this.currPressure,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currTemp': currTemp,
      'currStatus': currStatus,
      'currHumidity': currHumidity,
      'currWindSpeed': currWindSpeed,
      'currPressure': currPressure,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeather = map['list'][0];
      // final data = snapshot.data!;
  //         var currentWeather = data['list'][0];

  //         double currTemp = currentWeather['main']['temp'];
  //         String currStatus = currentWeather['weather'][0]['main']; // Clouds or Rain or Sunny?
  //         final currHumidity = currentWeather['main']['humidity'];
  //         final currWindSpeed = currentWeather['wind']['speed'];
  //         final currPressure = currentWeather['main']['pressure'];

    return WeatherModel(
      currTemp: currentWeather['main']['temp'],
      currStatus: currentWeather['weather'][0]['main'],
      currHumidity: currentWeather['main']['humidity'],
      currWindSpeed: currentWeather['wind']['speed'],
      currPressure: currentWeather['main']['pressure'],
    );
  }

  

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currTemp: $currTemp, currStatus: $currStatus, currHumidity: $currHumidity, currWindSpeed: $currWindSpeed, currPressure: $currPressure)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.currTemp == currTemp &&
      other.currStatus == currStatus &&
      other.currHumidity == currHumidity &&
      other.currWindSpeed == currWindSpeed &&
      other.currPressure == currPressure;
  }

  @override
  int get hashCode {
    return currTemp.hashCode ^
      currStatus.hashCode ^
      currHumidity.hashCode ^
      currWindSpeed.hashCode ^
      currPressure.hashCode;
  }
}
