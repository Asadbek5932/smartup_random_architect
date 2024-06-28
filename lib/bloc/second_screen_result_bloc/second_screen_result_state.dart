import 'package:dev_kit/window/page_bloc.dart';

class SecondScreenResultState extends PageState {
  bool isNumberReady;
  String choosenItem;

  SecondScreenResultState({this.isNumberReady = false, this.choosenItem = ''});

  SecondScreenResultState copyWith({bool? isNumberReady, String? choosenItem}) {
    return SecondScreenResultState(
        isNumberReady: isNumberReady ?? this.isNumberReady,
        choosenItem: choosenItem ?? this.choosenItem);
  }
}
