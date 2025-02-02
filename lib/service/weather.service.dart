import "package:weather_app/environment.dart";
import "http.service.dart";

class WeatherService {

  HttpService httpService = HttpService();

  Future<dynamic> fetchWeather() async {
    httpService.get('${Environment.weatherUrl}');
  }
}