import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_kh/models/weather_model.dart';

class WeatherProvider {
  Future<Weather> getCurrentWeather() async {
    final http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=Kharkiv&units=metric&APPID=1ea55013049215603ece3fee22806975');
    print(response);
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
