import 'dart:math';

import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:smartup_random_architect/bloc/second_screen_bloc/second_screen_event.dart';
import 'package:smartup_random_architect/bloc/second_screen_bloc/second_screen_state.dart';

import '../../screens/second_screen.dart';

class SecondScreenBloc extends PageBloc<SecondScreenPageView> {
  final TextEditingController textController = TextEditingController();

  SecondScreenBloc(SecondScreenPageView view)
      : super(view, SecondScreenInitialState()) {
    on<AddNewItemEvent>(_addNewItemToList);
    on<RemoveAnItemEvent>(_removeAnItem);
    on<ClearAllItemsEvent>(_clearAllItems);
    on<SecondScreenInitilizeListEvent>(_loadData);
    on<SecondScreenRandomlyChooseEvent>(_randomlyChoose);
  }
  
  void _loadData(SecondScreenInitilizeListEvent event, Emitter<PageState> emit) {
    final box = Hive.box('first');
    var list = box.get(0) ?? [];
    var currentState = state as SecondScreenState;
    emit(currentState.copyWith(listOfItems: list));
  }

  void _addNewItemToList(AddNewItemEvent event, Emitter<PageState> emit) async {
    String newItem = textController.text.trim();
    if (newItem.isNotEmpty) {
      final currentState = state as SecondScreenState;
      var newList = List<String>.from(currentState.listOfItems)..add(newItem);
      emit(currentState.copyWith(listOfItems: newList));
      textController.clear();
      final box = Hive.box('first');
      await box.put(0, newList);
    }
  }

  void _removeAnItem(RemoveAnItemEvent event, Emitter<PageState> emit) async {
    final currentState = state as SecondScreenState;
    var newList = currentState.listOfItems;
    newList.removeAt(event.index);
    final box = Hive.box('first');
    await box.put(0, newList);
    emit(SecondScreenState(listOfItems: newList));
  }

  void _clearAllItems(ClearAllItemsEvent event, Emitter<PageState> emit) async {
    var currentState = state as SecondScreenState;
    final box = Hive.box('first');
    await box.put(0, []);
    emit(currentState.copyWith(listOfItems: []));
  }

  void _randomlyChoose(SecondScreenRandomlyChooseEvent event, Emitter<PageState> emit) {
    final currentState = state as SecondScreenState;
    final random = Random();
    int index = random.nextInt(currentState.listOfItems.length);
    view.openGeneratedScreen(currentState.listOfItems, currentState.listOfItems[index]);
    // return list[index];
  }
}
