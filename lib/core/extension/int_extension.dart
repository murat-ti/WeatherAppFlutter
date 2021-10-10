import 'package:easy_localization/easy_localization.dart';

extension ParseDateExtension on int {
  String? toDate(var formatType) {
    try {
      var dt = DateTime.fromMillisecondsSinceEpoch(this * 1000);
      return DateFormat(formatType).format(dt);
    }
    catch(er) {
      return null;
    }
  }
}