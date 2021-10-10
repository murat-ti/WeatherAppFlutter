import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/base/view/base_view.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../bloc/splash_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashBloc>(
      viewModel: SplashBloc(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, SplashBloc viewModel) => Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('🏙️', style: TextStyle(fontSize: 64)),
              Text(
                LocaleKeys.loading.tr(),
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
