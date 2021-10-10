import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/init/lang/locale_keys.g.dart';

class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('🏙️', style: TextStyle(fontSize: 64)),
        Text(
          LocaleKeys.select_city.tr(),
          style: theme.textTheme.headline5,
        ),
      ],
    );
  }
}