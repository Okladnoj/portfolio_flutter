import 'package:flutter/material.dart';
import 'package:weather_kh/models/weather_model.dart';

class WeatherContainer extends StatelessWidget {
  final Weather weather;

  WeatherContainer({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Column(
            children: <Widget>[
              Text(
                '${weather.locationName}: ${weather.temperature} °C',
                textScaleFactor: 1.5,
                style: Theme.of(context).textTheme.display1,
                textAlign: TextAlign.center,
              ),
              Image.network(
                weather.iconUrl,
                scale: 1 / 1.5,
              ),
              Text(
                'Описание погоды:\n${weather.description}',
                textScaleFactor: 2,
                textAlign: TextAlign.center,
              ),
              Text(
                'Ветер: ${weather.speed} м/с' +
                    '\nНаправление: ${weather.deg}°',
                textScaleFactor: 1.3,
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(children: <Widget>[
                Text(
                  '${weather.locationName}: ${weather.temperature} °C',
                  textScaleFactor: 1.5,
                  style: Theme.of(context).textTheme.display1,
                  textAlign: TextAlign.center,
                ),
                Image.network(
                  weather.iconUrl,
                  scale: 1 / 1.5,
                )
              ]),
              Column(children: <Widget>[
                Text(
                  'Описание погоды:\n${weather.description}',
                  textScaleFactor: 2,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Ветер: ${weather.speed} м/с' +
                      '\nНаправление: ${weather.deg}°',
                  textScaleFactor: 1.3,
                  textAlign: TextAlign.center,
                )
              ])
            ],
          );
        }
      },
    );
  }
}
