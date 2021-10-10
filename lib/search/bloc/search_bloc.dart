import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../../core/class/callback.dart';
import '../../core/constants/app_constants.dart';
import '../../core/base/viewmodel/base_view_model.dart';

class SearchBloc extends BlocBase with BaseViewModel {
  final Callback callback;

  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  SearchBloc(this.callback);

  Future<void> getLocation({bool? defaultLocation}) async {
    LocationData? _locationData;
    if (defaultLocation != null) {
      //set default location value
      _locationData = LocationData.fromMap({'latitude': CoordinateConstants.latDefault, 'longitude': CoordinateConstants.lonDefault});
    } else {
      var location = Location();

      try {
        bool _serviceEnabled;
        PermissionStatus _permissionGranted;

        _serviceEnabled = await location.serviceEnabled();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            _locationData = null;
          }
        }

        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.granted) {
            _locationData = null;
          }
        }

        _locationData = await location.getLocation();
      } catch (e) {
        _locationData = null;
      }
    }

    callback.function(_locationData);
    Navigator.of(context!).pop();
  }
}
