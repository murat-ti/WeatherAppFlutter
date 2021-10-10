// ignore_for_file: prefer_const_constructors
import 'package:http/http.dart' as http;
import 'package:open_weather_map_api/open_weather_map_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenWeatherMapApiClient', () {
    late http.Client httpClient;
    late OpenWeatherMapApiClient openWeatherMapApiClient;

    setUpAll(() {
      registerFallbackValue<Uri>(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      openWeatherMapApiClient = OpenWeatherMapApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(OpenWeatherMapApiClient(), isNotNull);
      });
    });

    group('getDailyWeather', () {
      const lat = 50.45;
      const lon = 30.52;
      const baseUrl = 'api.openweathermap.org';
      const appId = '7542f68142d6be5f7b70b36ba8bd799c';

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);

        try {
          await openWeatherMapApiClient.getDailyWeather(lat, lon);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(baseUrl, '/data/2.5/onecall', {
              'appid': appId,
              'lat': '$lat',
              'lon': '$lon',
              'exclude': 'current,minutely,alerts,hourly',
              'units': 'metric',
            }),
          ),
        ).called(1);
      });

      test('throws DailyWeatherRequestFailure on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await openWeatherMapApiClient.getDailyWeather(lat, lon),
          throwsA(isA<WeatherRequestFailure>()),
        );
      });

      test('throws DailyWeatherNotFoundFailure on empty response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await openWeatherMapApiClient.getDailyWeather(lat, lon),
          throwsA(isA<WeatherNotFoundFailure>()),
        );
      });

      test('returns daily weather on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('''
          {"lat": 50.45,
          "lon": 30.52,
          "timezone": "America/Los_Angeles",
          "timezone_offset": -25200,
          "daily": [{
            "dt": 1633597200,
            "sunrise": 1633579640,
            "sunset": 1633620233,
            "moonrise": 1633582800,
            "moonset": 1633622700,
            "moon_phase": 0.03,
            "temp": {
                "day": 280.35,
                "min": 276.52,
                "max": 285.09,
                "night": 279.83,
                "eve": 283.58,
                "morn": 276.56
            },
            "feels_like": {
                "day": 277.13,
                "night": 277.56,
                "eve": 281.46,
                "morn": 273.25
            },
            "pressure": 1033,
            "humidity": 47,
            "dew_point": 270.19,
            "wind_speed": 5.37,
            "wind_deg": 100,
            "wind_gust": 10.9,
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "clouds": 1,
            "pop": 0,
            "uvi": 2.32
        }]}
        ''');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await openWeatherMapApiClient.getDailyWeather(lat, lon);
        expect(
          actual,
          isA<Location>()
              .having((w) => w.lat, 'lat', 50.45)
              .having((w) => w.lon, 'lon', 30.52)
              .having((w) => w.timezone, 'timezone', 'America/Los_Angeles')
              .having((w) => w.timezoneOffset, 'timezone_offset', -25200)
              .having((w) => w.daily!.first.dt, 'dt', 1633597200)
              .having((w) => w.daily!.first.sunrise, 'sunrise', 1633579640)
              .having((w) => w.daily!.first.sunset, 'sunset', 1633620233)
              .having((w) => w.daily!.first.moonrise, 'moonrise', 1633582800)
              .having((w) => w.daily!.first.moonset, 'moonset', 1633622700)
              .having((w) => w.daily!.first.moonPhase, 'moon_phase', 0.03)
              .having((w) => w.daily!.first.temp.day, 'day', 280.35)
              .having((w) => w.daily!.first.temp.min, 'min', 276.52)
              .having((w) => w.daily!.first.temp.max, 'max', 285.09)
              .having((w) => w.daily!.first.temp.night, 'night', 279.83)
              .having((w) => w.daily!.first.temp.eve, 'eve', 283.58)
              .having((w) => w.daily!.first.temp.morn, 'morn', 276.56)
              .having((w) => w.daily!.first.feelsLike.day, 'day', 277.13)
              .having((w) => w.daily!.first.feelsLike.night, 'night', 277.56)
              .having((w) => w.daily!.first.feelsLike.eve, 'eve', 281.46)
              .having((w) => w.daily!.first.feelsLike.morn, 'morn', 273.25)
              .having((w) => w.daily!.first.pressure, 'pressure', 1033)
              .having((w) => w.daily!.first.humidity, 'humidity', 47)
              .having((w) => w.daily!.first.dewPoint, 'dew_point', 270.19)
              .having((w) => w.daily!.first.windSpeed, 'wind_speed', 5.37)
              .having((w) => w.daily!.first.windDeg, 'wind_deg', 100)
              .having((w) => w.daily!.first.windGust, 'wind_gust', 10.9)
              .having((w) => w.daily!.first.weather.first.id, 'id', 800)
              .having((w) => w.daily!.first.weather.first.main, 'main', 'Clear')
              .having((w) => w.daily!.first.weather.first.description, 'description', 'clear sky')
              .having((w) => w.daily!.first.weather.first.icon, 'icon', '01d')
              .having((w) => w.daily!.first.clouds, 'clouds', 1)
              .having((w) => w.daily!.first.uvi, 'uvi', 2.32),
        );
      });
    });
  });
}
