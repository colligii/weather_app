import 'package:http/http.dart' as http;

class HttpService {
  Future<dynamic> get(String path) async {
    final response = await http.get(Uri.parse(path));

    if (response.statusCode >- 200 && response.statusCode <= 299) {
      return response.body;
    } else {
      throw Exception('Falha ao fazer requisição em API');
    }
  }
}