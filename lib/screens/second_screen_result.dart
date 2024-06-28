import 'package:dev_kit/dev_kit.dart';
import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smartup_random_architect/bloc/second_screen_result_bloc/second_screen_result_event.dart';
import 'package:smartup_random_architect/bloc/second_screen_result_bloc/second_screen_result_state.dart';
import '../bloc/second_screen_result_bloc/second_screen_result_bloc.dart';
import '../widgets/generated_item.dart';

class SecondScreenResult
    extends PageScreen<SecondScreenResultPageView, SecondScreenResultBloc>
    implements SecondScreenResultPageView {
  SecondScreenResult(super.navigation);

  static const String routeName = '/secondScreenResult';
  List<String> listOfItems = [];
  bool enteredFirstTime = true;

  @override
  PreferredSizeWidget? onBuildPageAppBar(
      BuildContext context, SecondScreenResultBloc bloc) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.result),
      centerTitle: false,
    );
  }

  @override
  Widget? onBuildPageBody(
      BuildContext context, SecondScreenResultBloc bloc, PageState state) {
    if (state is! SecondScreenResultState) {
      return Container();
    }

    if(enteredFirstTime) {
      bloc.add(SecondScreenResultRandomlyChooseEvent());
      enteredFirstTime = false;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!state.isNumberReady)
              Text(
                AppLocalizations.of(context)!.pleaseWait,
                style: TextStyle(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  fontSize: 20,
                ),
              ),
            if (state.isNumberReady)
              Text(
                AppLocalizations.of(context)!.result,
                style: TextStyle(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  fontSize: 20,
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            GeneratedItem(
              choosenItem: state.choosenItem,
              numberIsReady: state.isNumberReady,
              listOfItems: listOfItems,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 5, top: 10),
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.back,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5, right: 10, top: 10),
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    child: TextButton(
                      onPressed: () {
                        // TODO: implement the code
                        if(state.isNumberReady) {
                          bloc.add(SecondScreenResultRandomlyChooseEvent());
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.retry,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    listOfItems = bundle.getObject('listOfItems');
    super.initState();
  }

  @override
  List<String> get listOfUsers => listOfItems;
}

abstract class SecondScreenResultPageView extends PageViewInterface {
  List<String> get listOfUsers;
}
