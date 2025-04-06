import "package:http/http.dart" as http;
import "package:weather_app/SECRET_KEYS.dart";

class WeatherDataProvider {
  Future<String> getCurrentWeather (String cityName) async{
    
    try {
      // đang load
      /*isLoading = true;*/ // --- purely optional
        final result = await http.get(
        Uri.parse('$BASE_URL?q=$cityName&APPID=$API_KEY'), // add the api url here
      );
      // setState(() { // ---purely optional
      //   currTemp = data['list'][0]['main']['temp'];
      //   // load xông gồi
      //   isLoading = false;
      // });
      final data = result.body;
      
      //pls han hay return data..
      return data;
    } catch(e){
      throw "Something went wrong";
    }
    
  }
}