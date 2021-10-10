import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/init/lang/locale_keys.g.dart';

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('⛅', style: TextStyle(fontSize: 64)),
        Text(
          LocaleKeys.loading_weather.tr(),
          style: theme.textTheme.headline5,
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}