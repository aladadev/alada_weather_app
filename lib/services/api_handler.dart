import 'package:alada_weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiHandler {
  Future<CurrentWeather> getWeather(lat, lon) async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=f2f75c4840261086bf544385c7dd4318&units=metric');
    var response = await client.get(uri);
    print(response.statusCode);
    if (response.statusCode == 200) {
      try {
        var json = response.body;
        print(json);

        final currentweather = currentWeatherFromJson(json);
        return currentweather;
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    }
    throw "Json Parse Hoitase na baal";
  }
}
