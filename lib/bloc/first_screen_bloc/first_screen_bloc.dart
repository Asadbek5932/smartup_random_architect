import 'dart:async';
import 'dart:math';

import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartup_random_architect/bloc/first_screen_bloc/first_screen_state.dart';
import 'package:smartup_random_architect/screens/first_screen.dart';

import 'first_screen_event.dart';

class FirstScreenBloc extends PageBloc<FirstScreenPageView> {
  FirstScreenBloc(FirstScreenPageView view) : super(view, FirstScreenInitialState()) {
    on<DismissTheKeyboardEvent>(_dismissKeyboard);
    on<UpdateFirstNumberEvent>(_updateFirstNumber);
    on<UpdateSecondNumberEvent>(_updateSecondNumber);
    on<GenerateNumberEvent>(_generateNumber);
  }

  void _dismissKeyboard(
      DismissTheKeyboardEvent event, Emitter<PageState> emit) {
    FocusScope.of(event.context).unfocus();
  }

  void _updateFirstNumber(
      UpdateFirstNumberEvent event, Emitter<PageState> emit) {
    if (state is FirstScreenState) {
      final currentState = state as FirstScreenState;
      emit(currentState.copyWith(firstNumber: event.firstNumber));
    }
  }

  void _updateSecondNumber(
      UpdateSecondNumberEvent event, Emitter<PageState> emit) {
    if (state is FirstScreenState) {
      final currentState = state as FirstScreenState;
      emit(currentState.copyWith(secondNumber: event.secondNumber));
    }
  }

  void _generateNumber(GenerateNumberEvent event, Emitter<PageState> emit) async {
    if (state is FirstScreenState) {
      final currentState = state as FirstScreenState;
      int generatedNumber = _generateRandomNumber(currentState.firstNumber, currentState.secondNumber);
      emit(currentState.copyWith(
        generatedNumber: generatedNumber,
        buttonHasBeenPressed: true,
        numberIsReady: false
      ));
      await Future.delayed(const Duration(seconds: 2));
      emit(currentState.copyWith(
        generatedNumber: generatedNumber,
        numberIsReady: true,
        buttonHasBeenPressed: false
      ));
    }
  }

  int _generateRandomNumber(int from, int to) {
    final random = Random();
    return random.nextInt(to - from + 1) + from;
  }
}
