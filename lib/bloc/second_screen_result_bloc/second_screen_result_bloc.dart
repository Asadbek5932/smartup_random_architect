import 'dart:math';

import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartup_random_architect/bloc/second_screen_result_bloc/second_screen_result_event.dart';
import 'package:smartup_random_architect/bloc/second_screen_result_bloc/second_screen_result_state.dart';
import 'package:smartup_random_architect/screens/second_screen_result.dart';

class SecondScreenResultBloc extends PageBloc<SecondScreenResultPageView> {
  SecondScreenResultBloc(SecondScreenResultPageView view) : super(view, SecondScreenResultState()){
    on<SecondScreenResultRandomlyChooseEvent>(_randomlyChoose);
  }

  void _randomlyChoose(SecondScreenResultRandomlyChooseEvent event, Emitter<PageState> emit) async {
    final currentState = state as SecondScreenResultState;
    var list = view.listOfUsers;
    var random = Random();
    var randomIndex = random.nextInt(list.length);
    var chosenItem = list[randomIndex];
    emit(currentState.copyWith(choosenItem: chosenItem, isNumberReady: false));
    await Future.delayed(const Duration(seconds: 2));
    emit(currentState.copyWith(choosenItem: chosenItem, isNumberReady: true));
  }
}