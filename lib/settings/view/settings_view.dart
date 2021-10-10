import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/init/lang/language_manager.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../../core/base/view/base_view.dart';
import '../bloc/settings_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsBloc>(
      viewModel: SettingsBloc(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, SettingsBloc viewModel) => Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.settings.tr())),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text(LocaleKeys.language.tr()),
              trailing: DropdownButton<Locale>(items: [
                DropdownMenuItem(child: Text(LanguageManager.instance.ruLocale.countryCode!.toUpperCase()), value: LanguageManager.instance.ruLocale),
                DropdownMenuItem(child: Text(LanguageManager.instance.enLocale.countryCode!.toUpperCase()), value: LanguageManager.instance.enLocale),
              ], onChanged: (value) => viewModel.changeAppLocalization(context, value),
              ),
              subtitle: Text(LocaleKeys.change_language.tr()),
            )
          ],
        ),
      ),
    );
  }
}
