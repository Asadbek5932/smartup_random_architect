import 'dart:ui';

import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dev_kit/localization/localization.dart';
import '../../screens/launch_screen.dart';
import 'launch_screen_event.dart';
import 'launch_screen_state.dart';

class LaunchScreenBloc extends PageBloc<LaunchScreenPageView> {
  LaunchScreenBloc(LaunchScreenPageView view)
      : super(view, LaunchScreenInitialState()) {
    on<ChangeLocaleEvent>(_changeLocale);
    on<OpenFirstScreenEvent>(_openFirstScreen);
  }

  void _changeLocale(ChangeLocaleEvent event, Emitter<PageState> emit) {
    final localization = AppLocalization.shared;
    localization.setLanguage(Locale(event.locale));
    emit(LaunchScreenInitialState());
  }

  void _openFirstScreen(OpenFirstScreenEvent event, Emitter<PageState> emit) {

  }
}
