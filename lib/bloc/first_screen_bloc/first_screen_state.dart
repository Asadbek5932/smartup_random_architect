import 'package:dev_kit/window/page_bloc.dart';

class FirstScreenState extends PageState {
  bool buttonHasBeenPressed;
  int firstNumber;
  int secondNumber;
  int generatedNumber;
  bool numberIsReady;

  FirstScreenState(
      {this.buttonHasBeenPressed = false,
      this.firstNumber = 1,
      this.secondNumber = 100,
      this.generatedNumber = -1,
      this.numberIsReady = false});

  FirstScreenState copyWith({
    bool? buttonHasBeenPressed,
    int? firstNumber,
    int? secondNumber,
    int? generatedNumber,
    bool? numberIsReady,
  }) {
    return FirstScreenState(
      buttonHasBeenPressed: buttonHasBeenPressed ?? this.buttonHasBeenPressed,
      firstNumber:  firstNumber ?? this.firstNumber,
      secondNumber: secondNumber ?? this.secondNumber,
      generatedNumber: generatedNumber ?? this.generatedNumber,
      numberIsReady: numberIsReady ?? this.numberIsReady
    );
  }
}

class FirstScreenInitialState extends FirstScreenState {}
