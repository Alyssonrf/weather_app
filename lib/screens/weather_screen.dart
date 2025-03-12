import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';
import '../utils/snackbar_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  final TextEditingController _cityController = TextEditingController();

  Future<void> _fetchWeather() async {
    final cityName = _cityController.text;
    if (cityName.isEmpty) return;

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      if (mounted) {
        showCustomSnackBar(context, 'Erro ao buscar o clima: $e',
            isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previsão do Tempo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Nome da Cidade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: const Text('Buscar Clima'),
            ),
            const SizedBox(height: 32),
            if (_weather != null)
              Column(
                children: [
                  Text(
                    'Cidade: ${_weather!.cityName}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Temperatura: ${_weather!.temperature}°C',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Descrição: ${_weather!.description}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Image.network(
                    'http://openweathermap.org/img/wn/${_weather!.icon}@2x.png',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
