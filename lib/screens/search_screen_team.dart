import 'package:dev_kit/dev_kit.dart';
import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartup_random_architect/bloc/search_screen_team_bloc/search_screen_team_event.dart';
import 'package:smartup_random_architect/bloc/search_screen_team_bloc/search_screen_team_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../bloc/search_screen_team_bloc/search_screen_team_bloc.dart';
import '../models/team.dart';

class SearchScreenTeam
    extends PageScreen<SearchScreenTeamPageView, SearchScreenTeamBloc>
    implements SearchScreenTeamPageView {
  SearchScreenTeam(super.navigation);

  List<Team> listOfUsers = [];
  bool firstTimeLaunch = true;
  static const String routeName = '/searchScreenTeam';

  @override
  PreferredSizeWidget? onBuildPageAppBar(
      BuildContext context, SearchScreenTeamBloc bloc) {
    final state = bloc.state as SearchScreenTeamState;

    return AppBar(
      title: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: TextField(
            controller: bloc.textController,
            onChanged: (text) {
              bloc.add(SeachScreenTeamSearchingEvent(text: text));
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  bloc.textController.clear();
                  bloc.add(SeachScreenTeamSearchingEvent(text: ''));
                },
                icon: const Icon(Icons.clear),
              ),
              hintText: AppLocalizations.of(context)!.search,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget? onBuildPageBody(
      BuildContext context, SearchScreenTeamBloc bloc, PageState state) {
    if(state is! SearchScreenTeamState) {return Container();}
    if(firstTimeLaunch) {
      firstTimeLaunch = false;
      bloc.add(SearchScreenTeamInitilizeEvent());
    }
    
    return state.filteredList.isEmpty
        ? Center(child: Text(AppLocalizations.of(context)!.emptyList))
        : ListView.builder(
            itemCount: state.filteredList.length,
            itemBuilder: (ctx, idx) {
              return Dismissible(
                key: Key(state.filteredList[idx].id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  bloc.add(SearchScreenTeamRemoveItemEvent(item: state.filteredList[idx]));
                },
                child: Column(children: [
                  ListTile(
                    title: Text(state.filteredList[idx].name),
                    subtitle: Text(state.filteredList[idx].level),
                    trailing: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        bloc.add(SearchScreenTeamRemoveItemEvent(item: state.filteredList[idx]));
                      },
                    ),
                  ),
                  const Divider()
                ]),
              );
            },
          );
  }

  @override
  void initState() {
    listOfUsers = bundle.getObject<List<Team>>('listOfUsers');
    super.initState();
  }

  @override
  List<Team> get getListOfUsers => listOfUsers;
}

abstract class SearchScreenTeamPageView extends PageViewInterface {
  List<Team> get getListOfUsers;
}
