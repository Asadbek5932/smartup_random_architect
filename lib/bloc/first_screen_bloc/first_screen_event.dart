import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/cupertino.dart';

class FirstScreenEvent extends PageEvent {}

class DismissTheKeyboardEvent extends FirstScreenEvent {
  BuildContext context;
  DismissTheKeyboardEvent(this.context);
}

class UpdateFirstNumberEvent extends FirstScreenEvent {
  final int firstNumber;
  UpdateFirstNumberEvent(this.firstNumber);
}

class UpdateSecondNumberEvent extends FirstScreenEvent {
  final int secondNumber;
  UpdateSecondNumberEvent(this.secondNumber);
}

class GenerateNumberEvent extends FirstScreenEvent {

}