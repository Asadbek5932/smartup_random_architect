import 'dart:ui';

import 'package:dev_kit/localization/localization.dart';
import 'package:dev_kit/window/page_bloc.dart';

class LaunchScreenEvent extends PageEvent {
}

class ChangeLocaleEvent extends LaunchScreenEvent {
   String locale;
   ChangeLocaleEvent(this.locale);
}

class OpenFirstScreenEvent extends LaunchScreenEvent {

}