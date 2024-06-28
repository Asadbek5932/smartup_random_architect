import 'package:dev_kit/dev_kit.dart';
import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartup_random_architect/bloc/search_screen_bloc/search_screen_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smartup_random_architect/bloc/search_screen_bloc/search_screen_state.dart';

import '../bloc/search_screen_bloc/search_screen_event.dart';

class SearchScreen extends PageScreen<SearchScreenPageView, SearchScreenBloc>
    implements SearchScreenPageView {
  SearchScreen(super.navigation);

  bool theFirstAttemt = true;
  List<String> listOfItems = [];

  static const String routeName = '/searchScreen';

  @override
  PreferredSizeWidget? onBuildPageAppBar(
      BuildContext context, SearchScreenBloc bloc) {
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
              bloc.add(SearchScreenEditTextEvent());
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  bloc.textController.clear();
                  bloc.add(SearchScreenEditTextEvent());
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
      BuildContext context, SearchScreenBloc bloc, PageState state) {
    if (state is! SearchScreenState) return Container();

    if (theFirstAttemt) {
      bloc.add(
          SearchSreenInitilizeFilteredListEvent(filteredList: listOfItems));
      theFirstAttemt = false;
    }

    return state.filteredList.isEmpty
        ? Center(child: Text(AppLocalizations.of(context)!.emptyList))
        : ListView.builder(
            itemCount: state.filteredList.length,
            itemBuilder: (ctx, idx) {
              return Dismissible(
                key: Key(state.filteredList[idx]),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  // _removeItem(filteredList[idx]);
                  bloc.add(SearchScreenRemoveItemEvent(word: state.filteredList[idx]));
                },
                child: Column(children: [
                  ListTile(
                    title: Text(state.filteredList[idx]),
                    trailing: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        bloc.add(SearchScreenRemoveItemEvent(word: state.filteredList[idx]));
                        // _removeItem(filteredList[idx]);
                      },
                    ),
                  ),
                  const Divider()
                ]),
              );
            });
  }

  @override
  void initState() {
    listOfItems = bundle.getObject<List<String>>('listOfItems');
    super.initState();
  }

  @override
  List<String> get getListOfUsers => this.listOfItems;
}

abstract class SearchScreenPageView extends PageViewInterface {
  List<String> get getListOfUsers;
}
