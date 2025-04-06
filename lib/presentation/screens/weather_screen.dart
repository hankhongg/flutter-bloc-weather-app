import 'dart:convert';
import 'dart:ui';
import 'dart:core';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/additional_card.dart';
import '../widgets/hourly_weather_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/SECRET_KEYS.dart';
import 'package:intl/intl.dart';

class WeatherApp extends StatefulWidget{
  WeatherApp({super.key});
  _WeatherAppState createState() => _WeatherAppState();
}
class _WeatherAppState extends State<WeatherApp>{
  String convertToC(double k){
    return (k - 273.15).toStringAsFixed(2);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(WeatherFetched(-1));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(icon: Icon(Icons.refresh_rounded), onPressed: ()=>{
            BlocProvider.of<WeatherBloc>(context).add(WeatherFetched(-1)),
          }),
        ]
      ),
      body: 
      BlocBuilder<WeatherBloc, WeatherState>(
        builder:(context, state) {
          if (state is WeatherError){
            return Center(child: Text(state.errorMessage),);
          }
          if (state is !WeatherSuccess){
            return const Center(child: CircularProgressIndicator());
          }

          final data = state.weatherModel;

          final currTemp = data.currTemp;
          final currStatus = data.currStatus;
          final currHumidity = data.currHumidity;
          final currWindSpeed = data.currWindSpeed;
          final currPressure = data.currPressure;

          return Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(children: [
                            Text("${(convertToC(currTemp).toString())}°C", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 16,),
                            Icon(currStatus == 'Clouds' ? Icons.cloud : currStatus == 'Rain' ? Icons.thunderstorm : Icons.sunny, size: 64),
                            const SizedBox(height: 16,),
                            Text(currStatus, style: TextStyle(fontSize: 20),),
                            const SizedBox(height: 6,)
                          ],),
                        )
                      ),
                    )
                  ),
                ),
                const SizedBox(height: 14),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Hourly Forecast", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
                ),
                const SizedBox(height: 12),
                
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,

                    itemBuilder: (context, index) {
                      BlocProvider.of<WeatherBloc>(context).add(WeatherFetched(index+1));
                      final hourlyForecast = state.hourlyModel;
                      return HourlyWeatherCard(
                        time: hourlyForecast.time,
                        temp: hourlyForecast.temp,
                        icon: hourlyForecast.iconName == 'Clouds' ? Icons.cloud : currStatus == 'Rain' ? Icons.thunderstorm : Icons.sunny,
                      );
                    }
                  ),
                ),

                const SizedBox(height: 14),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Additional Information", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  AddtionalCard(icon: Icons.water_drop, string: "Humidity", value: currHumidity.toInt()),
                  AddtionalCard(icon: Icons.air, string: "Wind Speed", value: currWindSpeed.toInt()),
                  AddtionalCard(icon: Icons.beach_access, string: "Pressure", value: currPressure.toInt()),
                ],),
              ],),
            );
        },
        ),
    );
  }
}



