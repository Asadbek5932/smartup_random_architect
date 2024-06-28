import 'dart:ui';

import 'package:dev_kit/localization/localization.dart';

mixin SmartupRandomLocalization implements AppLocalization {
  @override
  List<Locale> get supportedLanguages => [const Locale("en"), const Locale("ru")];
}