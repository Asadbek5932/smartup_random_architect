import 'package:dev_kit/dependency_injection.dart';
import 'package:smartup_random_architect/bloc/first_screen_bloc/first_screen_bloc.dart';
import 'package:smartup_random_architect/bloc/launch_screen_bloc/launch_screen_bloc.dart';
import 'package:smartup_random_architect/bloc/search_screen_bloc/search_screen_bloc.dart';
import 'package:smartup_random_architect/bloc/search_screen_team_bloc/search_screen_team_bloc.dart';
import 'package:smartup_random_architect/bloc/second_screen_bloc/second_screen_bloc.dart';
import 'package:smartup_random_architect/bloc/second_screen_result_bloc/second_screen_result_bloc.dart';
import 'package:smartup_random_architect/bloc/third_screen_bloc/third_screen_bloc.dart';
import 'package:smartup_random_architect/screens/first_screen.dart';
import 'package:smartup_random_architect/screens/launch_screen.dart';
import 'package:smartup_random_architect/screens/search_screen.dart';
import 'package:smartup_random_architect/screens/search_screen_team.dart';
import 'package:smartup_random_architect/screens/second_screen.dart';
import 'package:smartup_random_architect/screens/second_screen_result.dart';
import 'package:smartup_random_architect/screens/third_screen.dart';

class BlocProvider {
  static void init() {
    DIContainer.register(LaunchScreenPageView,
        (view) => LaunchScreenBloc(view as LaunchScreenPageView));
    DIContainer.register(FirstScreenPageView,
        (view) => FirstScreenBloc(view as FirstScreenPageView));
    DIContainer.register(SecondScreenPageView,
        (view) => SecondScreenBloc(view as SecondScreenPageView));
    DIContainer.register(ThirdScreenPageView,
        (view) => ThirdScreenBloc(view as ThirdScreenPageView));
    DIContainer.register(SearchScreenPageView,
        (view) => SearchScreenBloc(view as SearchScreenPageView));
    DIContainer.register(SecondScreenResultPageView,
        (view) => SecondScreenResultBloc(view as SecondScreenResultPageView));
    DIContainer.register(SearchScreenTeamPageView,
        (view) => SearchScreenTeamBloc(view as SearchScreenTeamPageView));
  }
}
