import 'package:dev_kit/window/page_bloc.dart';
import 'package:smartup_random_architect/bloc/search_screen_bloc/search_screen_event.dart';
import 'package:smartup_random_architect/models/team.dart';

class SearchScreenTeamEvent extends PageEvent {}

class SearchScreenTeamInitilizeEvent extends SearchScreenTeamEvent {}

class SeachScreenTeamSearchingEvent extends SearchScreenTeamEvent {
  final String text;

  SeachScreenTeamSearchingEvent({required this.text});
}

class SearchScreenTeamRemoveItemEvent extends SearchScreenTeamEvent {
  Team item;
  SearchScreenTeamRemoveItemEvent({required this.item});
}
