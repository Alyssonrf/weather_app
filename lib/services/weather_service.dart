import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = 'gEdOVolrcXHGFjXe5TkEQezy7uz0MrhQ';
  final String baseUrl = 'https://api.tomorrow.io/v4/weather/realtime';

  Future<Weather> getWeather(String cityName) async {
    // Para simplificar, vamos usar uma API de geocoding para obter as coordenadas da cidade.
    // Você pode usar uma API como OpenCage ou Nominatim para isso.
    final geoResponse = await http.get(
      Uri.parse(
          'https://api.opencagedata.com/geocode/v1/json?q=Recife&key=8d15d6dec27a4bbfb9ca5d6ff629eb22'),
    );

    if (geoResponse.statusCode != 200) {
      throw Exception('Falha ao obter coordenadas da cidade');
    }

    final geoData = jsonDecode(geoResponse.body);
    final lat = geoData['results'][0]['geometry']['lat'];
    final lon = geoData['results'][0]['geometry']['lng'];

    // Agora, faça a requisição para a Tomorrow.io
    final response = await http.get(
      Uri.parse('$baseUrl?location=$lat,$lon&apikey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Falha ao carregar os dados do clima');
    }
  }
}
