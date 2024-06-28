import 'package:dev_kit/dev_kit.dart';
import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smartup_random_architect/bloc/launch_screen_bloc/launch_screen_event.dart';
import 'package:smartup_random_architect/screens/first_screen.dart';
import 'package:smartup_random_architect/screens/second_screen.dart';
import 'package:smartup_random_architect/screens/third_screen.dart';

import '../bloc/launch_screen_bloc/launch_screen_bloc.dart';

class LaunchScreen extends PageScreen<LaunchScreenPageView, LaunchScreenBloc>
    implements LaunchScreenPageView {
  static const String routeName = '/';
  var defaultLanguage = 'English';

  LaunchScreen(super.navigation);

  @override
  Widget? onBuildPageBody(
      BuildContext context, LaunchScreenBloc bloc, PageState state) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/smartup_random.png'),
                const SizedBox(height: 70),
                Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        openFirstScreen();
                      },
                      child: Container(
                        width: 220,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.randomNumber,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // presenter.openRandomListScreen(context);
                        openSecondScreen();
                      },
                      child: Container(
                        width: 220,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.randomList,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // presenter.openRandomTeamScreen(context);
                        openThirdScreen();
                      },
                      child: Container(
                        width: 220,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.randomGroup,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }


  @override
  PreferredSizeWidget? onBuildPageAppBar(BuildContext context, LaunchScreenBloc bloc) {
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: DropdownButton<String>(
            style: const TextStyle(color: Colors.black),
            value: defaultLanguage,
            onChanged: (String? language) {
              if (language == 'English') {
                defaultLanguage = 'English';
                bloc.add(ChangeLocaleEvent('en'));
              } else if (language == 'Russian') {
                defaultLanguage = 'Russian';
                bloc.add(ChangeLocaleEvent('ru'));
              }
            },
            items: const [
              DropdownMenuItem(
                value: 'English',
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Text('🇺🇸 English'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'Russian',
                child: Row(
                  children: [
                    SizedBox(width: 8),
                    Text('🇷🇺 Русский'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      backgroundColor: Colors.white,
    );
  }

  @override
  void openFirstScreen() {
    navigation.openRoute(context, FirstScreen.routeName);
  }

  @override
  void openSecondScreen() {
    navigation.openRoute(context, SecondScreen.routeName);
  }

  @override
  void openThirdScreen() {
    navigation.openRoute(context, ThirdScreen.routeName);
  }
}

abstract class LaunchScreenPageView extends PageViewInterface {
  String get defaultLanguage;
  void openFirstScreen();

  void openSecondScreen();
  void openThirdScreen();
}
