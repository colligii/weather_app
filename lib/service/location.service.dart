import "../environment.dart";
import "http.service.dart";

class LocationService {

  HttpService httpService = HttpService();

  Future<dynamic> getAllCountrys() async {
    return httpService.get("${Environment.restCountryUrl}/all");
  }

}