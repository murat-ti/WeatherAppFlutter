import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../../core/init/navigation/constants/navigation_constants.dart';
import '../../core/base/viewmodel/base_view_model.dart';

class SplashBloc extends BlocBase with BaseViewModel {
  final _splashDelay = 1;

  @override
  void init() {
    _loadWidget();
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  Timer _loadWidget() {
    var _duration = Duration(seconds: _splashDelay);
    return Timer(_duration, loadHomeScreen);
  }

  Future<void> loadHomeScreen() async {
    await navigation.navigateToPageClear(path: NavigationConstants.homeView);
  }
}
