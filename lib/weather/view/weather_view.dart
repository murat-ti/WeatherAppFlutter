import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/constants/app_constants.dart';
import 'package:weather/core/init/lang/locale_keys.g.dart';
import 'package:weather/core/init/navigation/constants/navigation_constants.dart';
import 'package:weather/weather/bloc/weather_state.dart';
import 'package:weather/weather/models/enums/weather_type.dart';
import 'package:weather/weather/widgets/widgets.dart';
import 'package:weather_repository/weather_repository.dart';
import '../../core/base/view/base_view.dart';
import '../bloc/weather_bloc.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<WeatherBloc>(
      viewModel: WeatherBloc(WeatherRepository()),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, WeatherBloc viewModel) => Scaffold(
        appBar: buildAppBar(context, viewModel),
        body: buildBody(viewModel),
        floatingActionButton: buildFloatActionButton(context, viewModel),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, WeatherBloc viewModel) {
    return AppBar(
      title: Text(LocaleKeys.weather.tr()),
      actions: [
        DropdownButton<WeatherType>(items: [
          DropdownMenuItem(child: Text(WeatherType.daily.value), value: WeatherType.daily),
          DropdownMenuItem(child: Text(WeatherType.hourly.value), value: WeatherType.hourly),
        ], onChanged: (value) => viewModel.toggleWeatherType(value),
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () async {
            await viewModel.openPage(NavigationConstants.settingsView);
          },
        ),
      ],
    );
  }

  Widget buildBody(WeatherBloc viewModel) {
    return Center(
      child: StreamBuilder(
        stream: viewModel.outWeatherState,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.data == null) {
            return const WeatherEmpty();
          }
          else if(snapshot.data.status == WeatherStatus.loading) {
            return const WeatherLoading();
          }
          else if(snapshot.data.status == WeatherStatus.success) {
            return WeatherPopulated(
              weather: snapshot.data.weather,
              onRefresh: () {
                //TODO refresh method
                return viewModel.fetchWeather(CoordinateConstants.latDefault, CoordinateConstants.lonDefault);
              },
            );
          }
          else {
            return const WeatherError();
          }
        },
      ),
    );
  }

  Widget buildFloatActionButton(BuildContext context, WeatherBloc viewModel) {
    return FloatingActionButton(
      child: const Icon(Icons.search),
      onPressed: () async {
        await viewModel.openPage(NavigationConstants.searchView);
      },
    );
  }
}
