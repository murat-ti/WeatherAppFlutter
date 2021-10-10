// ignore_for_file: prefer_const_constructors
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:weather/weather/cubit/weather_cubit.dart';
import 'package:weather_repository/weather_repository.dart' as weather_repository;
import 'helpers/hydrated_bloc.dart';

const weatherLat = 50.45;
const weatherLon = 30.52;
const weatherCondition = 'Clear';
const weatherTemperature = 9.8;

class MockWeatherRepository extends Mock
    implements weather_repository.WeatherRepository {}

class MockWeather extends Mock implements weather_repository.Weather {}

void main() {
  group('WeatherCubit', () {
    late weather_repository.Weather weather;
    late weather_repository.WeatherRepository weatherRepository;

    setUpAll(initHydratedBloc);

    setUp(() {
      weather = MockWeather();
      weatherRepository = MockWeatherRepository();
      when(() => weather.condition).thenReturn(weatherCondition);
      when(() => weather.temperature).thenReturn(weatherTemperature);
      when(
            () => weatherRepository.getDailyWeather(any(),any()),
      ).thenAnswer((_) async => weather);
    });

    test('initial state is correct', () {
      final weatherCubit = WeatherCubit(weatherRepository);
      expect(weatherCubit.state, WeatherState());
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        final weatherCubit = WeatherCubit(weatherRepository);
        expect(
          weatherCubit.fromJson(weatherCubit.toJson(weatherCubit.state)),
          weatherCubit.state,
        );
      });
    });

    group('fetchDailyWeather', () {
      blocTest<WeatherCubit, WeatherState>(
        'emits nothing when lat and lon are null',
        build: () => WeatherCubit(weatherRepository),
        act: (cubit) => cubit.fetchWeather(null, null),
        expect: () => <WeatherState>[],
      );

      blocTest<WeatherCubit, WeatherState>(
        'calls getWeather with correct lat and lon',
        build: () => WeatherCubit(weatherRepository),
        act: (cubit) => cubit.fetchWeather(weatherLat, weatherLon),
        verify: (_) {
          verify(() => weatherRepository.getDailyWeather(weatherLat, weatherLon)).called(1);
        },
      );

      blocTest<WeatherCubit, WeatherState>(
        'emits [loading, failure] when getWeather throws',
        setUp: () {
          when(
                () => weatherRepository.getDailyWeather(any(), any()),
          ).thenThrow(Exception('oops'));
        },
        build: () => WeatherCubit(weatherRepository),
        act: (cubit) => cubit.fetchWeather(weatherLat, weatherLon),
        expect: () => <WeatherState>[
          WeatherState(status: WeatherStatus.loading),
          WeatherState(status: WeatherStatus.failure),
        ],
      );
    });
  });
}