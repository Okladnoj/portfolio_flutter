class Weather {
  final int temperature;
  final String locationName;
  final String iconUrl;
  final int speed;
  final int deg;
  final String description;

  Weather(this.temperature, this.locationName, this.iconUrl,
      {this.speed, this.description, this.deg});

  Weather.fromJson(Map<String, dynamic> json)
      : temperature = json['main']['temp'],
        locationName = json['name'],
        iconUrl = _generateIconUrl(json['weather'][0]['icon']),
        speed = json['wind']['speed'],
        deg = json['wind']['deg'],
        description = json['weather'][0]['description'];

  static String _generateIconUrl(String icon) {
    return 'https://openweathermap.org/img/wn/$icon@2x.png';
  }
}
