import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:smartup_random_architect/bloc/search_screen_bloc/search_screen_event.dart';
import 'package:smartup_random_architect/bloc/search_screen_bloc/search_screen_state.dart';

import '../../screens/search_screen.dart';

class SearchScreenBloc extends PageBloc<SearchScreenPageView> {
  final TextEditingController textController = TextEditingController();

  SearchScreenBloc(SearchScreenPageView view)
      : super(view, SearchScreenState()) {
    on<SearchSreenInitilizeFilteredListEvent>(_initilizeFilteredList);
    on<SearchScreenEditTextEvent>(_editingTheText);
    on<SearchScreenRemoveItemEvent>(_removeItem);
  }
  void _initilizeFilteredList (SearchSreenInitilizeFilteredListEvent event, Emitter<PageState> emit) {
    emit(SearchScreenState(filteredList: event.filteredList));
  }

  void _editingTheText(SearchScreenEditTextEvent event, Emitter<PageState> emit) {
    final String text = textController.text.trim().toLowerCase();
    List<String> newFilteredList = [];
    for(String word in view.getListOfUsers) {
      if(word.trim().toLowerCase().contains(text)) {
        newFilteredList.add(word);
      }
    }
    emit(SearchScreenState(filteredList: newFilteredList));
  }

  void _removeItem(SearchScreenRemoveItemEvent event, Emitter<PageState> emit) async {
    final currentState = state as SearchScreenState;
    var list = currentState.filteredList;
    list.remove(event.word);
    view.getListOfUsers.remove(event.word);
    final box = Hive.box('first');
    await box.put(0, view.getListOfUsers);
    emit(currentState.copyWith(list));
  }
}
