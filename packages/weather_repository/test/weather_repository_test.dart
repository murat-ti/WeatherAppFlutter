// ignore_for_file: prefer_const_constructors
import 'package:open_weather_map_api/open_weather_map_api.dart' as open_weather_map_api;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather_repository/weather_repository.dart';

class MockOpenWeatherMapApiClient extends Mock
    implements open_weather_map_api.OpenWeatherMapApiClient {}

class MockWeather extends Mock implements open_weather_map_api.DailyWeather {}

void main() {
  group('WeatherRepository', () {
    late open_weather_map_api.OpenWeatherMapApiClient openWeatherMapApiClient;
    late WeatherRepository weatherRepository;

    setUp(() {
      openWeatherMapApiClient = MockOpenWeatherMapApiClient();
      weatherRepository = WeatherRepository(
        weatherApiClient: openWeatherMapApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal OpenWeatherMapApiClient when not injected', () {
        expect(WeatherRepository(), isNotNull);
      });
    });

    group('getWeather', () {
      const lat = 37.42;
      const lon = -122.08;

      test('calls getDailyWeather with correct lat, lon', () async {
        try {
          await weatherRepository.getDailyWeather(lat, lon);
        } catch (_) {}
        verify(() => openWeatherMapApiClient.getDailyWeather(lat, lon)).called(1);
      });

      test('throws when getDailyWeather fails', () async {
        final exception = Exception('oops');
        when(() => openWeatherMapApiClient.getDailyWeather(any(), any()))
            .thenThrow(exception);
        expect(
              () async => await weatherRepository.getDailyWeather(lat, lon),
          throwsA(exception),
        );
      });
    });
  });
}