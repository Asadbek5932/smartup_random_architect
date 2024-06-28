import 'package:dev_kit/window/page_bloc.dart';

class SecondScreenState extends PageState {
  final List<String> listOfItems;

  SecondScreenState({this.listOfItems = const []});

  SecondScreenState copyWith({
    List<String>? listOfItems,
  }) {
    return SecondScreenState(
      listOfItems: listOfItems ?? this.listOfItems,
    );
  }
}

class SecondScreenInitialState extends SecondScreenState {
  SecondScreenInitialState() : super(listOfItems: const []);
}
