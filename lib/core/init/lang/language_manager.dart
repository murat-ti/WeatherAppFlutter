import 'dart:io';

import 'package:flutter/material.dart';
import '../../constants/enums/locale_keys_enum.dart';
import '../cache/locale_manager.dart';

class LanguageManager {
  static LanguageManager? _instance;

  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  final ruLocale = const Locale('ru', 'RU');
  final enLocale = const Locale('en', 'US');

  Locale? _appLocale;

  int get defaultLocaleIndex => 1;

  Locale get appLocale => _appLocale ?? supportedLocales[defaultLocaleIndex];

  set appLocale(Locale locale) => _appLocale = locale;

  LanguageManager._init() {
    //system default language
    final String _defaultSystemLocale = Platform.localeName;
    if (_defaultSystemLocale.isNotEmpty) {
      var _temp = _defaultSystemLocale.split('_');
      if (_temp.length == 2) {
        Locale locale = Locale(_temp[0], _temp[1]);
        if (supportedLocales.contains(locale)) {
          _appLocale = Locale(_temp[0], _temp[1]);
        }
      }
    } else {
      //try get from shared pref
      var language = LocaleManager.instance.getStringValue(PreferencesKeys.localeLanguage);
      var country = LocaleManager.instance.getStringValue(PreferencesKeys.localeCountry);
      if (language.isNotEmpty) {
        _appLocale = Locale(language, country);
      } else {
        _appLocale = supportedLocales[defaultLocaleIndex];
      }
    }
  }

  List<Locale> get supportedLocales => [ruLocale, enLocale];

  Map toDropdown() {
    var languageList = {};

    languageList[0] = 'Русский';
    languageList[1] = 'English';

    return languageList;
  }
}
