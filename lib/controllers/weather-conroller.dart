import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherController {
  String endpoint = "https://api.open-meteo.com/v1/forecast?latitude=59.44&longitude=24.75&current_weather=true";

  Future<String> fetchWeather() async {
    http.Response response = await http.get(Uri.parse(endpoint));
    Map<String, dynamic> weather = jsonDecode(response.body);
    String weatherString = weather["current_weather"]["temperature"].toString() +"° C, wind speed: " + weather["current_weather"]["windspeed"].toString() + " m/s "+weather["current_weather"]["winddirection"].toString()+"° wind direction " + weather["current_weather"]["time"].toString();
    return weatherString;
  }
}