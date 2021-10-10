import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'core/constants/app_constants.dart';
import 'core/init/cache/locale_manager.dart';
import 'core/init/lang/language_manager.dart';

Future<void> main() async {
  await init();
  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: ApplicationConstants.langAssetPath,
      startLocale: LanguageManager.instance.appLocale,
      fallbackLocale: LanguageManager.instance.enLocale,
      child: const App(),
    ),
  );
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await LocaleManager.preferencesInit();
  await EasyLocalization.ensureInitialized();
  //TODO disable logs
  //EasyLocalization.logger.enableBuildModes = [];
}
