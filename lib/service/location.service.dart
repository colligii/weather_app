import "../environment.dart";
import "http.service.dart";

class LocationService {
  const LocationService();

  final HttpService httpService = const HttpService();

  Future<dynamic> getAllCountrys() async {
    return httpService.get("${Environment.restCountryUrl}/all");
  }

}