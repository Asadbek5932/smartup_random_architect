import 'package:dev_kit/window/page_bloc.dart';

class SecondScreenEvent extends PageEvent {}

class AddNewItemEvent extends SecondScreenEvent {}

class RemoveAnItemEvent extends SecondScreenEvent {
  final int index;

  RemoveAnItemEvent({required this.index});
}

class ClearAllItemsEvent extends SecondScreenEvent {}

class SecondScreenInitilizeListEvent extends SecondScreenEvent {}

class SecondScreenRandomlyChooseEvent extends SecondScreenEvent {}
