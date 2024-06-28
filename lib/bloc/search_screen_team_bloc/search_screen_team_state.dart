import 'package:dev_kit/window/page_bloc.dart';
import 'package:smartup_random_architect/models/team.dart';

class SearchScreenTeamState extends PageState {
  List<Team> filteredList;

  SearchScreenTeamState(
      {this.filteredList = const []}) {}

  SearchScreenTeamState copyWith(
      {List<Team>? listOfUsers, List<Team>? filteredList}) {
    return SearchScreenTeamState(
        filteredList: filteredList ?? this.filteredList);
  }
}
