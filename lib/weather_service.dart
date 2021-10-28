import 'dart:convert';

import 'package:http/http.dart' as http;
import 'weather.dart';

const baseUrl = 'http://apiadvisor.climatempo.com.br/api/v1/anl/synoptic/locale';

class NetworkHelper {
  static Future<dynamic> getData(String url) async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
class WeatherService {
  static Future<Weather> fetchWeather(String country, String token) async {
    final String url = '$baseUrl/$country?token=$token';
    final response = await NetworkHelper.getData(url);

    return Weather.fromJson(response[0]);
  }
}