import 'package:open_weather_map_api/open_weather_map_api.dart';
import 'package:test/test.dart';

void main() {
  group('Weather', () {
    group('fromJson', () {
      test('returns TimeZone for Location', () {
        expect(
          Location.fromJson(<String, dynamic>{
            "lat": 37.42,
            "lon": -122.08,
            "timezone": "America/Los_Angeles",
            "timezone_offset": -25200,
            "daily": [
              {
                'dt': 1633597200,
                'sunrise': 1633579640,
                'sunset': 1633620233,
                'moonrise': 1633582800,
                'moonset': 1633622700,
                'moon_phase': 0.03,
                'temp': {'day': 281.2, 'min': 275.26, 'max': 285.09, 'night': 279.83, 'eve': 283.58, 'morn': 275.7},
                'feels_like': {'day': 278.2, 'night': 277.56, 'eve': 281.46, 'morn': 272.2},
                'pressure': 1035,
                'humidity': 36,
                'dew_point': 267.73,
                'wind_speed': 5.37,
                'wind_deg': 100,
                'wind_gust': 10.9,
                'weather': [
                  {'id': 800, 'main': 'Clear', 'description': 'clear sky', 'icon': '01d'}
                ],
                'clouds': 2,
                'pop': 0,
                'uvi': 2.32
              },
              {
                'dt': 1633597200,
                'sunrise': 1633579640,
                'sunset': 1633620233,
                'moonrise': 1633582800,
                'moonset': 1633622700,
                'moon_phase': 0.03,
                'temp': {'day': 281.2, 'min': 275.26, 'max': 285.09, 'night': 279.83, 'eve': 283.58, 'morn': 275.7},
                'feels_like': {'day': 278.2, 'night': 277.56, 'eve': 281.46, 'morn': 272.2},
                'pressure': 1035,
                'humidity': 36,
                'dew_point': 267.73,
                'wind_speed': 5.37,
                'wind_deg': 100,
                'wind_gust': 10.9,
                'weather': [
                  {'id': 800, 'main': 'Rain', 'description': 'clear sky', 'icon': '01d'}
                ],
                'clouds': 2,
                'pop': 0,
                'uvi': 2.32
              }
            ]
          }),
          /*isA<Location>().having(
            (w) => w.timezone,
            'timezone',
            'America/Los_Angeles',
          ),*/
          isA<Location>().having(
                (w) => w.daily!.last.weather.first.main,
            'main',
            'Rain',
          ),
        );
      });

      test('returns Clear for DailyWeather weather first item', () {
        expect(
          DailyWeather.fromJson(<String, dynamic>{
            'dt': 1633597200,
            'sunrise': 1633579640,
            'sunset': 1633620233,
            'moonrise': 1633582800,
            'moonset': 1633622700,
            'moon_phase': 0.03,
            'temp': {'day': 281.2, 'min': 275.26, 'max': 285.09, 'night': 279.83, 'eve': 283.58, 'morn': 275.7},
            'feels_like': {'day': 278.2, 'night': 277.56, 'eve': 281.46, 'morn': 272.2},
            'pressure': 1035,
            'humidity': 36,
            'dew_point': 267.73,
            'wind_speed': 5.37,
            'wind_deg': 100,
            'wind_gust': 10.9,
            'weather': [
              {'id': 800, 'main': 'Clear', 'description': 'clear sky', 'icon': '01d'}
            ],
            'clouds': 2,
            'pop': 0,
            'uvi': 2.32
          }),
          isA<DailyWeather>().having(
            (w) => w.weather.first.main,
            'main',
            'Clear',
          ),
        );
      });

      test('returns Clear for HourlyWeather weather first item', () {
        expect(
          HourlyWeather.fromJson(<String, dynamic>{
            "dt": 1633582800,
            "temp": 276.53,
            "feels_like": 273.2,
            "pressure": 1030,
            "humidity": 70,
            "dew_point": 271.77,
            "uvi": 0,
            "clouds": 0,
            "visibility": 10000,
            "wind_speed": 3.72,
            "wind_deg": 99,
            "wind_gust": 10.38,
            "weather": [
              {"id": 800, "main": "Clear", "description": "clear sky", "icon": "01d"}
            ],
            "pop": 0
          }),
          isA<HourlyWeather>().having(
            (w) => w.weather.first.main,
            'main',
            'Clear',
          ),
        );
      });
    });
  });
}
