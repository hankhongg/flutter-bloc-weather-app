import "package:flutter_bloc/flutter_bloc.dart";
import "package:weather_app/data/repository/hourly_repository.dart";
import "package:weather_app/data/repository/weather_repository.dart";
import "package:weather_app/models/hourly_model.dart";
import "package:weather_app/models/weather_model.dart";

part "weather_event.dart";
part "weather_state.dart";


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  // di weather repository
  final WeatherRepository weatherRepository;
  final HourlyRepository hourlyRepository;
  WeatherBloc(this.weatherRepository, this.hourlyRepository) : super(WeatherInitial()){
    void _onWeatherFetched(WeatherFetched event, Emitter<WeatherState> emit) async {
      emit(WeatherLoading());
      try {
        final weather = await weatherRepository.getCurrentWeather(); // đã convert json thành model
        final hourly = await hourlyRepository.getHourlyWeather(event.atIndex); // đã convert json thành model
        emit(WeatherSuccess(weather, hourly));
      } catch (e) {
        emit(WeatherError(e.toString()));
      } 
    }
    
    on<WeatherFetched>(_onWeatherFetched);
  }
}

