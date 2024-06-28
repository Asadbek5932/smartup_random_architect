import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smartup_random_architect/bloc/third_screen_bloc/third_screen_event.dart';
import 'package:smartup_random_architect/bloc/third_screen_bloc/third_screen_state.dart';
import 'package:smartup_random_architect/widgets/random_team_logic.dart';

import '../bloc/third_screen_bloc/third_screen_bloc.dart';
import '../models/team.dart';

class Utils {
  static void showAlertDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  static void displayDialog(
      {required String title,
      required String content,
      required BuildContext context,
      required int index,
      required ThirdScreenBloc bloc,
      required PageState state}) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  if (state is ThirdScreenInitialState) {
                    state.listOfUsers[index].level =
                        AppLocalizations.of(context)!.easy;
                    state.listOfUsers[index].levelNumber = 0;
                    bloc.add(ThirdScreenUpdateUserEvent(
                        team: state.listOfUsers[index]));
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.easy,
                  textAlign: TextAlign.left,
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  if (state is ThirdScreenInitialState) {
                    state.listOfUsers[index].level =
                        AppLocalizations.of(context)!.medium;
                    state.listOfUsers[index].levelNumber = 1;
                    bloc.add(ThirdScreenUpdateUserEvent(
                        team: state.listOfUsers[index]));
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.medium,
                  textAlign: TextAlign.left,
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  if (state is ThirdScreenInitialState) {
                    state.listOfUsers[index].level =
                        AppLocalizations.of(context)!.hard;
                    state.listOfUsers[index].levelNumber = 2;
                    bloc.add(ThirdScreenUpdateUserEvent(
                        team: state.listOfUsers[index]));
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.hard,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: const TextStyle(color: Colors.green),
              ),
            )
          ],
        );
      },
    );
  }

  static void displayResultDialog(
      {required ThirdScreenBloc bloc, required PageState state, required BuildContext context, required List<List<Team>> teams}) async {
    if(state is! ThirdScreenInitialState){ return; }
    int size = state.listOfUsers.length;
    int cnt = size;
    cnt = size ~/ 2;
    print(cnt);
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.divideTeams),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < cnt; i++)
                if (size % (cnt - i) == 0)
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => RandomTeamLogic(
                                  myList: teams!
                                      .where((element) =>
                                          element.length == (cnt - i))
                                      .toList(),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "${size ~/ (cnt - i)} ${AppLocalizations.of(context)!.groups} ${cnt - i} ${AppLocalizations.of(context)!.players}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Divider()
                      ],
                    ),
                  )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: const TextStyle(
                  color: Colors.lightGreen,
                  fontSize: 20,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
