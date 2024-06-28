import 'package:dev_kit/dev_kit.dart';
import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smartup_random_architect/bloc/second_screen_bloc/second_screen_bloc.dart';
import 'package:smartup_random_architect/bloc/second_screen_bloc/second_screen_event.dart';
import 'package:smartup_random_architect/bloc/second_screen_bloc/second_screen_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smartup_random_architect/screens/search_screen.dart';
import 'package:smartup_random_architect/screens/second_screen_result.dart';
import 'package:smartup_random_architect/widgets/utils.dart';

class SecondScreen extends PageScreen<SecondScreenPageView, SecondScreenBloc>
    implements SecondScreenPageView {
  SecondScreen(super.navigation);

  static const String routeName = '/secondScreen';

  @override
  Widget? onBuildPageBody(
      BuildContext context, SecondScreenBloc bloc, PageState state) {
    if (state is! SecondScreenState) return Container();
    if (state.listOfItems.isEmpty) {
      bloc.add(SecondScreenInitilizeListEvent());
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: state.listOfItems.isEmpty
                ? Center(
                    child: Text(
                    AppLocalizations.of(context)!.emptyList,
                    style: const TextStyle(color: Colors.black),
                  ))
                : ListView.builder(
                    itemCount: state.listOfItems.length,
                    itemBuilder: (ctx, idx) {
                      return Dismissible(
                        key: Key(state.listOfItems[idx]),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          bloc.add(RemoveAnItemEvent(index: idx));
                        },
                        child: Column(children: [
                          ListTile(
                            title: Text(state.listOfItems[idx]),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                bloc.add(RemoveAnItemEvent(index: idx));
                              },
                            ),
                          ),
                          const Divider()
                        ]),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: bloc.textController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enterValue,
                          hintStyle: const TextStyle(color: Colors.white60),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16),
                      color: Colors.lightGreen,
                      child: TextButton(
                        onPressed: () {
                          bloc.add(AddNewItemEvent());
                        },
                        child: Text(
                          AppLocalizations.of(context)!.add.toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 16,
                  margin: const EdgeInsets.only(bottom: 15),
                  color: Colors.pinkAccent,
                  child: TextButton(
                    onPressed: () {
                      if (state.listOfItems.length > 1) {
                        // presenter.openRandomlyChoosenResultScreen(
                        //     context, listOfItems);
                        bloc.add(SecondScreenRandomlyChooseEvent());
                      } else {
                        Utils.showAlertDialog(
                            context,
                            AppLocalizations.of(context)!.attention,
                            AppLocalizations.of(context)!
                                .quantityMustBeMoreThanOne);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.generate.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? onBuildPageAppBar(
      BuildContext context, SecondScreenBloc bloc) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context)!.randomList,
        style: const TextStyle(fontSize: 15),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            final currentState = bloc.state as SecondScreenState;
            openSearchScreen(currentState.listOfItems);
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!.attention),
                      content:
                          Text(AppLocalizations.of(context)!.alertClearMessage),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.cancel)),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                bloc.add(ClearAllItemsEvent());
                                Navigator.pop(context);
                              });
                            },
                            child: Text(AppLocalizations.of(context)!.yes)),
                      ],
                    ));
          },
        ),
      ],
    );
  }

  @override
  void openSearchScreen(List<String> listOfItems) {
    final Bundle newBundle = Bundle.newBundle(context);
    newBundle.putObject('listOfItems', listOfItems);
    navigation.openRoute(context, SearchScreen.routeName, bundle: newBundle);
  }

  @override
  void openGeneratedScreen(List<String> listOfItems, String choosenItem) {
    final Bundle newBundle = Bundle.newBundle(context);
    newBundle.putObject('listOfItems', listOfItems);
    navigation.openRoute(context, SecondScreenResult.routeName, bundle: newBundle);
  }
}

abstract class SecondScreenPageView extends PageViewInterface {
  void openSearchScreen(List<String> listOfItems);

  void openGeneratedScreen(List<String> listOfItems, String choosenItem);
}
