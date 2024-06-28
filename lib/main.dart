import 'dart:async';

import 'package:dev_kit/application/application.dart';
import 'package:dev_kit/localization/localization.dart';
import 'package:dev_kit/window/window.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smartup_random_architect/bloc/bloc_provider.dart';
import 'package:smartup_random_architect/screens/first_screen.dart';
import 'package:smartup_random_architect/screens/launch_screen.dart';
import 'package:smartup_random_architect/screens/search_screen.dart';
import 'package:smartup_random_architect/screens/search_screen_team.dart';
import 'package:smartup_random_architect/screens/second_screen.dart';
import 'package:smartup_random_architect/screens/second_screen_result.dart';
import 'package:smartup_random_architect/screens/third_screen.dart';

import 'models/team.dart';

final Application _application = MyApp();

void main() {
  _application.run();
}

class MyApp extends Application {
  @override
  Route getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case LaunchScreen.routeName:
        return MaterialPageRoute(builder: (context) {
          return Window(LaunchScreen(navigationController), context);
        });
      case FirstScreen.routeName:
        return MaterialPageRoute(builder: (context) {
          return Window(FirstScreen(navigationController), context);
        });
      case SecondScreen.routeName:
        return MaterialPageRoute(builder: (context) {
          return Window(SecondScreen(navigationController), context);
        });
      case ThirdScreen.routeName:
        return MaterialPageRoute(builder: (context) {
          return Window(ThirdScreen(navigationController), context);
        });
      case SearchScreen.routeName:
        return MaterialPageRoute(
            builder: (ctx) => Window(SearchScreen(navigationController), ctx),
            settings: settings);
      case SecondScreenResult.routeName:
        return MaterialPageRoute(
            builder: (ctx) =>
                Window(SecondScreenResult(navigationController), ctx),
            settings: settings);
      case SearchScreenTeam.routeName:
        return MaterialPageRoute(
            builder: (ctx) =>
                Window(SearchScreenTeam(navigationController), ctx),
            settings: settings);
      default:
        return MaterialPageRoute(builder: (context) {
          return Window(FirstScreen(navigationController), context);
        });
    }
  }

  @override
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(TeamAdapter());
    await Hive.openBox('first');
    await Hive.openBox('second');
    await Hive.openBox('language');
    AppLocalization.initialize(const Locale('en'));
    BlocProvider.init();
  }

  @override
  Localization get localization => AppLocalization.shared;
}
