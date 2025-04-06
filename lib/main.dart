import "package:flutter/material.dart";
import "package:weather_app/bloc/weather_bloc.dart";
import "package:weather_app/data/data_provider/weather_data_provider.dart";
import "package:weather_app/data/repository/hourly_repository.dart";
import "package:weather_app/data/repository/weather_repository.dart";
import "presentation/screens/weather_screen.dart";
import "package:flutter_bloc/flutter_bloc.dart";


void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  Widget build(BuildContext build){
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WeatherRepository>(
          create: (context) => WeatherRepository(weatherDataProvider: WeatherDataProvider()),
        ),
        RepositoryProvider<HourlyRepository>(
          create: (context) => HourlyRepository(weatherDataProvider: WeatherDataProvider()),
        ),
      ],
      child: BlocProvider(
        create: (context) => WeatherBloc(context.read<WeatherRepository>(), context.read<HourlyRepository>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(useMaterial3: true,),
          home: WeatherApp(),
        ),
      ),
    );
  }
}