import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:smartup_random_architect/bloc/search_screen_bloc/search_screen_event.dart';
import 'package:smartup_random_architect/bloc/search_screen_team_bloc/search_screen_team_event.dart';
import 'package:smartup_random_architect/bloc/search_screen_team_bloc/search_screen_team_state.dart';
import 'package:smartup_random_architect/models/team.dart';
import 'package:smartup_random_architect/screens/search_screen_team.dart';

class SearchScreenTeamBloc extends PageBloc<SearchScreenTeamPageView> {

  final textController = TextEditingController();

  SearchScreenTeamBloc(SearchScreenTeamPageView view) : super(view, SearchScreenTeamState()) {
    on<SearchScreenTeamInitilizeEvent>(_initilize);
    on<SeachScreenTeamSearchingEvent>(_searching);
    on<SearchScreenTeamRemoveItemEvent>(_removeItem);
  }

  void _initilize(SearchScreenTeamInitilizeEvent event, Emitter<PageState> emit) {
    final currentState = state as SearchScreenTeamState;
    emit(currentState.copyWith(filteredList: view.getListOfUsers));
  }

  void _searching(SeachScreenTeamSearchingEvent event, Emitter<PageState> emit) {
    final String text = textController.text.trim().toLowerCase();
    List<Team> newFilteredList = [];
    for(Team word in view.getListOfUsers) {
      if(word.name.trim().toLowerCase().contains(text)) {
        newFilteredList.add(word);
      }
    }
    emit(SearchScreenTeamState(filteredList: newFilteredList));
  }

  Future<void> _removeItem(SearchScreenTeamRemoveItemEvent event, Emitter<PageState> emit) async {
    final currentState = state as SearchScreenTeamState;
    var list = currentState.filteredList;
    list.remove(event.item);
    view.getListOfUsers.remove(event.item);
    final box = Hive.box('second');
    await box.put(0, view.getListOfUsers);
    emit(currentState.copyWith(listOfUsers: list));
  }
}