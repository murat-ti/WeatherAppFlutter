import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weather/core/class/callback.dart';
import 'package:weather/core/constants/app_constants.dart';
import '../models/enums/weather_type.dart';
import '../../core/extension/double_extension.dart';
import '../../core/init/navigation/constants/navigation_constants.dart';
import '../../core/base/viewmodel/base_view_model.dart';
import '../models/weather.dart';
import 'package:weather_repository/weather_repository.dart' show WeatherRepository;

import 'weather_state.dart';

class WeatherBloc extends BlocBase with BaseViewModel {
  final _weatherController = BehaviorSubject<WeatherState>();
  LocationData? location;
  WeatherType _weatherType = WeatherType.daily;
  double _lat = CoordinateConstants.latDefault;
  double _lon = CoordinateConstants.lonDefault;

  //output of data/**/
  ValueStream<WeatherState> get outWeatherState => _weatherController.stream; //stream
  //input of data
  Sink<WeatherState> get inWeatherState => _weatherController.sink;

  late Stream<WeatherState> weatherState;

  WeatherBloc(this._weatherRepository) {
    weatherState = outWeatherState;
  }

  final WeatherRepository _weatherRepository;

  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void dispose() {
    super.dispose();
    _weatherController.close();
  }

  fetchWeather(double? lat, double? lon, [type=WeatherType.hourly]) async {
    WeatherState state = WeatherState();
    inWeatherState.add(state.copyWith(status: WeatherStatus.loading));

    if (lat == null || lon == null) return;

    try {
      //convert Weather from Repo to Main
      WeatherType _wtype = type;
      final weather = Weather.fromRepositoryList(
        await _weatherRepository.getDailyWeather(lat, lon, _wtype.toExcept),
      );

      inWeatherState.add(
        state.copyWith(status: WeatherStatus.success, weather: weather),
      );
    } on Exception {
      inWeatherState.add(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> openPage(String route) async {
    switch (route) {
      case NavigationConstants.searchView:
        await navigation.navigateToPage(
            path: route,
            data: Callback(function: (value) {
              //need to take 2 numbers after dot, otherwise api not take arguments
              _lat = value.latitude;
              _lon = value.longitude;

              fetchWeather(_lat.toPrecision(2), _lon.toPrecision(2));
            }));
        break;
      default:
        await navigation.navigateToPage(path: route);
        break;
    }
  }

  void toggleWeatherType(WeatherType? type) {
    _weatherType = type ?? WeatherType.daily;
    fetchWeather(_lat, _lon, _weatherType);
  }
}
