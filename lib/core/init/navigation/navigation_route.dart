import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../settings/view/settings_view.dart';
import '../../../search/view/search_view.dart';
import 'widget/not_found_page.dart';
import '../../../weather/view/weather_view.dart';
import 'constants/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.settingsView:
        return normalNavigate(const SettingsView(), const RouteSettings(name: NavigationConstants.settingsView));
      case NavigationConstants.searchView:
        return normalNavigate(SearchView(callback: args.arguments), const RouteSettings(name: NavigationConstants.searchView));
      case NavigationConstants.homeView:
        return normalNavigate(const WeatherView(), const RouteSettings(name: NavigationConstants.homeView));
      default:
        return normalNavigate(const NotFoundPage(), const RouteSettings(name: 'Not found'));
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
