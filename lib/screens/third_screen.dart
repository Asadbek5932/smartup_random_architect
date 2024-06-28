import 'package:dev_kit/dev_kit.dart';
import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smartup_random_architect/bloc/third_screen_bloc/third_screen_event.dart';
import 'package:smartup_random_architect/bloc/third_screen_bloc/third_screen_state.dart';
import 'package:smartup_random_architect/models/team.dart';
import 'package:smartup_random_architect/screens/search_screen.dart';
import 'package:smartup_random_architect/screens/search_screen_team.dart';
import 'package:smartup_random_architect/widgets/utils.dart';
import '../bloc/third_screen_bloc/third_screen_bloc.dart';
import '../widgets/bottom_for_team_screen.dart';

class ThirdScreen extends PageScreen<ThirdScreenPageView, ThirdScreenBloc>
    implements ThirdScreenPageView {
  static const String routeName = '/thirdScreen';
  bool firstTimeLaunched = true;

  ThirdScreen(super.navigation);

  @override
  PreferredSizeWidget? onBuildPageAppBar(BuildContext context,
      ThirdScreenBloc bloc) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.randomGroup),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            final currentState = bloc.state as ThirdScreenInitialState;
            final newList = currentState.listOfUsers;
            openSearchScreen(newList);
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) =>
                  AlertDialog(
                    title: Text(AppLocalizations.of(context)!.attention),
                    content: Text(
                        AppLocalizations.of(context)!.alertClearMessage),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          bloc.add(ThirdScreenClearEverythingEvent());
                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.yes),
                      )
                    ],
                  ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget? onBuildPageBody(BuildContext context, ThirdScreenBloc bloc,
      PageState state) {
    if (state is! ThirdScreenInitialState) {
      return Container();
    }

    if (firstTimeLaunched) {
      bloc.add(ThirdScreenLoadDataEvent(context: context));
      firstTimeLaunched = false;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Theme
              .of(context)
              .appBarTheme
              .backgroundColor,
          child: ListTile(
            leading: Text(
              AppLocalizations.of(context)!.players,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            trailing: Text(
              state.listOfUsers.length.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        state.listOfUsers.isEmpty
            ? Center(child: Text(AppLocalizations.of(context)!.emptyList))
            : Expanded(
          child: ListView.builder(
            itemCount: state.listOfUsers.length,
            itemBuilder: (ctx, idx) {
              return Dismissible(
                key: Key(state.listOfUsers[idx].id),
                onDismissed: (direction) {
                  bloc.add(ThirdScreenRemoveUserEvent(
                      team: state.listOfUsers[idx]));
                },
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Utils.displayDialog(
                          title: AppLocalizations.of(context)!.choose,
                          content: AppLocalizations.of(context)!.level,
                          context: context,
                          index: idx,
                          bloc: bloc,
                          state: state,
                        );
                      },
                      title: Text(state.listOfUsers[idx].name),
                      subtitle: Text(state.listOfUsers[idx].level),
                      trailing: IconButton(
                        onPressed: () {
                          bloc.add(ThirdScreenRemoveUserEvent(
                              team: state.listOfUsers[idx]));
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    const Divider()
                  ],
                ),
              );
            },
          ),
        ),
        BottomForTeamScreen(bloc: bloc, state: state)
      ],
    );
  }

  @override
  void openSearchScreen(List<Team> listOfItems) {
    final Bundle newBundle = Bundle.newBundle(context);
    newBundle.putObject('listOfUsers', listOfItems);
    navigation.openRoute(context, SearchScreenTeam.routeName, bundle: newBundle);
  }
}

abstract class ThirdScreenPageView extends PageViewInterface {
  void openSearchScreen(List<Team> listOfItems);
}
