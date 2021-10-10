// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/base/view/base_view.dart';
import '../../core/init/lang/locale_keys.g.dart';
import '../bloc/search_bloc.dart';

class SearchView extends StatelessWidget {
  final callback;
  const SearchView({Key? key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchBloc>(
      viewModel: SearchBloc(callback),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, SearchBloc viewModel) => Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.city_search.tr())),
        body: Row(
          children: [
            buildActionChip(
              context,
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.location_pin, color: Colors.blue),
              ),
              LocaleKeys.get_location.tr(),
              () async {
                await viewModel.getLocation();
              },
            ),
            buildActionChip(
              context,
              null,
              CoordinateConstants.cityDefault,
              () async {
                await viewModel.getLocation(defaultLocation: true);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActionChip(BuildContext context, Widget? avatar, String label, VoidCallback callback) {
    return ActionChip(avatar: avatar ?? const SizedBox(), label: Text(label), onPressed: callback);
  }
}
