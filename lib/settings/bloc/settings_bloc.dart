import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/constants/enums/locale_keys_enum.dart';
import '../../core/init/cache/locale_manager.dart';
import '../../core/init/lang/language_manager.dart';
import '../../core/base/viewmodel/base_view_model.dart';

class SettingsBloc extends BlocBase with BaseViewModel {

  @override
  void init() {}

  @override
  void setContext(BuildContext context) => this.context = context;

  Future<void> changeAppLocalization(BuildContext context, Locale? locale) async {
    LocaleManager localeManager = LocaleManager.instance;
    if (locale != null && LanguageManager.instance.supportedLocales.contains(locale)) {
      await localeManager.setStringValue(PreferencesKeys.localeLanguage, locale.languageCode);
      await localeManager.setStringValue(PreferencesKeys.localeCountry, locale.countryCode ?? '');
      await context.setLocale(locale);
      LanguageManager.instance.appLocale = locale;
    }
  }
}
