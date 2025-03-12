class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final String? location = json['location']['name'];
    final temp = json['data']['values']['temperature'];
    final desc = json['data']['values']['weatherCode'];
    final icon = _getWeatherIcon(json['data']['values']['weatherCode']);

    return Weather(
      cityName: location ?? 'Recife',
      temperature: temp,
      description: _getWeatherDescription(desc),
      icon: icon,
    );
  }

  // Método para converter o código do tempo em uma descrição legível
  static String _getWeatherDescription(int weatherCode) {
    // Exemplo de mapeamento (consulte a documentação da Tomorrow.io para códigos completos)
    switch (weatherCode) {
      case 1000:
        return 'Céu limpo';
      case 1100:
        return 'Parcialmente nublado';
      case 4000:
        return 'Chuva';
      default:
        return 'Desconhecido';
    }
  }

  // Método para obter o ícone com base no código do tempo
  static String _getWeatherIcon(int weatherCode) {
    // Exemplo de mapeamento (consulte a documentação da Tomorrow.io para códigos completos)
    switch (weatherCode) {
      case 1000:
        return '01d'; // Ícone de sol
      case 1100:
        return '02d'; // Ícone de nuvens parcialmente nubladas
      case 4000:
        return '10d'; // Ícone de chuva
      default:
        return '01d'; // Ícone padrão
    }
  }
}
