import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_kh/models/weather_model.dart';
import 'package:weather_kh/net/weather_prov.dart';
import 'package:weather_kh/views/view_weather.dart';

class MyApp extends StatelessWidget {
  final _weatherProvider = WeatherProvider();
  @override
  Widget build(BuildContext context) {
    final weather =
        Weather(30, 'Kharkiv', 'http://openweathermap.org/img/wn/10d@2x.png');
    return MaterialApp(
      title: 'Weather DEMO',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather Overview'),
        ),
        body: Center(
            child: FutureBuilder<Weather>(
          future: _weatherProvider.getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WeatherContainer(weather: snapshot.data);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        )),
      ),
    );
  }
}
