import 'package:dev_kit/localization/localization.dart';
import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:smartup_random_architect/bloc/third_screen_bloc/third_screen_event.dart';
import 'package:smartup_random_architect/bloc/third_screen_bloc/third_screen_state.dart';
import 'package:smartup_random_architect/models/team.dart';
import 'package:smartup_random_architect/screens/third_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smartup_random_architect/widgets/utils.dart';

class ThirdScreenBloc extends PageBloc<ThirdScreenPageView> {
  ThirdScreenBloc(ThirdScreenPageView view)
      : super(view, ThirdScreenInitialState(listOfUsers: [])) {
    on<ThirdScreenAddNewUserEvent>(_addNewUser);
    on<ThirdScreenRemoveUserEvent>(_removeUser);
    on<ThirdScreenUpdateUserEvent>(_updateUser);
    on<ThirdScreenLoadDataEvent>(_loadData);
    on<ThirdScreenClearEverythingEvent>(_clearEverything);
    on<ThirdScreenGenerateGroupsEvent>(_generateGroups);
  }

  _addNewUser(ThirdScreenAddNewUserEvent event, Emitter<PageState> emit) async {
    final currentState = state as ThirdScreenInitialState;
    var newList = List<Team>.from(currentState.listOfUsers);
    newList.add(event.team);
    emit(currentState.copyWith(listOfUsers: newList));
    final box = Hive.box('second');
    await box.put(0, newList);
  }

  _removeUser(ThirdScreenRemoveUserEvent event, Emitter<PageState> emit) async {
    final currentState = state as ThirdScreenInitialState;
    var newList = List<Team>.from(currentState.listOfUsers);
    newList.remove(event.team);
    emit(currentState.copyWith(listOfUsers: newList));
    final box = Hive.box('second');
    await box.put(0, newList);
  }

  _updateUser(ThirdScreenUpdateUserEvent event, Emitter<PageState> emit) async {
    final currentState = state as ThirdScreenInitialState;
    var newList = List<Team>.from(currentState.listOfUsers);
    final updatedUser = event.team;
    final index = newList.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      newList[index] = updatedUser;
    }
    emit(currentState.copyWith(listOfUsers: newList));
    final box = Hive.box('second');
    await box.put(0, newList);
  }

  _loadData(ThirdScreenLoadDataEvent event, Emitter<PageState> emit) async {
    final currentState = state as ThirdScreenInitialState;
    final box = Hive.box('second');
    var list = box.get(0);
    if (list != null && list is List) {
      List<Team> teamList = list.cast<Team>();
      for (var x in teamList) {
        switch (x.levelNumber) {
          case 0:
            x.level = AppLocalizations.of(event.context)!.easy;
          case 1:
            x.level = AppLocalizations.of(event.context)!.medium;
          case 2:
            x.level = AppLocalizations.of(event.context)!.hard;
          default:
            break;
        }
      }
      emit(currentState.copyWith(listOfUsers: teamList));
    } else {
      emit(currentState.copyWith(listOfUsers: []));
    }
  }

  void _clearEverything(
      ThirdScreenClearEverythingEvent event, Emitter<PageState> emit) async {
    final box = Hive.box('second');
    await box.put(0, []);
    final currentState = state as ThirdScreenInitialState;
    emit(currentState.copyWith(listOfUsers: []));
  }

  void _generateGroups(
      ThirdScreenGenerateGroupsEvent event, Emitter<PageState> emit) {
    final currentState = state as ThirdScreenInitialState;
    if (currentState.listOfUsers.length > 1) {
      var teams = distributeTeams(currentState.listOfUsers);
      Utils.displayResultDialog(
          bloc: event.bloc, state: state, context: event.context, teams: teams);
    } else {
      showDialog(
        context: event.context,
        builder: (ctx) => AlertDialog(
          title: Text(AppLocalizations.of(event.context)!.attention),
          content: Text(
              AppLocalizations.of(event.context)!.quantityMustBeMoreThanOne),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(event.context).pop();
              },
              child: Text(AppLocalizations.of(event.context)!.ok),
            )
          ],
        ),
      );
    }
  }

  bool isPrime(int n) {
    if (n <= 1) {
      return false;
    }

    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) {
        return false;
      }
    }

    return true;
  }

  List<List<Team>> distributeTeams(List<Team> listOfUsers) {
    List<List<Team>> result = [];
    List<Team> workList = List.from(listOfUsers);

    if (isPrime(workList.length)) {
      for (var item in workList) {
        result.add([item]);
      }
      return result;
    }
    workList.sort((a, b) => a.levelNumber.compareTo(b.levelNumber));

    int l = 0;
    int r = workList.length - 1;
    List<Team> temp = [];
    int cnt = workList.length;
    cnt ~/= 2;

    while (cnt != 0) {
      if (workList.length % cnt != 0) {
        cnt--;
        continue;
      }
      while (l <= r) {
        if (temp.length < cnt) {
          temp.add(workList[l]);
          l++;
        }
        if (temp.length < cnt) {
          temp.add(workList[r]);
          r--;
        }
        if (temp.length == cnt) {
          result.add(temp);
          temp = [];
        }
      }
      l = 0;
      r = workList.length - 1;
      cnt--;
      temp.clear();
    }
    return result;
  }
}
