import 'package:dev_kit/dev_kit.dart';
import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smartup_random_architect/bloc/first_screen_bloc/first_screen_bloc.dart';
import 'package:smartup_random_architect/bloc/first_screen_bloc/first_screen_event.dart';
import 'package:smartup_random_architect/bloc/first_screen_bloc/first_screen_state.dart';
import '../widgets/generated_number.dart';

class FirstScreen extends PageScreen<FirstScreenPageView, FirstScreenBloc>
    implements FirstScreenPageView {
  static const String routeName = '/firstScreen';

  FirstScreen(super.navigation);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget? onBuildPageBody(
      BuildContext context, FirstScreenBloc bloc, PageState state) {
    if (state is! FirstScreenState) return Container();

    return PopScope(
      onPopInvoked: (value) {
        // Handle pop if necessary
      },
      child: GestureDetector(
        onTap: () {
          bloc.add(DismissTheKeyboardEvent(context));
        },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                if (state.generatedNumber != -1)
                  Expanded(
                    flex: 1,
                    child: GeneratedNumber(
                      generatedNumber: state.generatedNumber,
                      numberIsReady: state.numberIsReady,
                    ),
                  ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .from,
                                          ),
                                          keyboardType: TextInputType.number,
                                          initialValue:
                                              state.firstNumber.toString(),
                                          validator: (value) {
                                            if (value == null ||
                                                value.length > 9 ||
                                                int.parse(value) < 0) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .enterValidNumber;
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {
                                              bloc.add(UpdateFirstNumberEvent(
                                                  int.parse(value)));
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText:
                                                AppLocalizations.of(context)!
                                                    .util,
                                          ),
                                          keyboardType: TextInputType.number,
                                          initialValue:
                                              state.secondNumber.toString(),
                                          validator: (value) {
                                            if (value == null ||
                                                value.length > 8 ||
                                                int.parse(value) < 0) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .enterValidNumber;
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            if (value != null) {
                                              bloc.add(UpdateSecondNumberEvent(
                                                  int.parse(value)));
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      _formKey.currentState?.save();
                                      if(!state.buttonHasBeenPressed) {
                                        bloc.add(GenerateNumberEvent());
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    color: !state.buttonHasBeenPressed
                                        ? Colors.pinkAccent
                                        : Colors.grey,
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.generate,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? onBuildPageAppBar(
      BuildContext context, FirstScreenBloc bloc) {
    return AppBar(
      centerTitle: false,
      title: Text(AppLocalizations.of(context)!.randomNumber),
    );
  }
}

abstract class FirstScreenPageView extends PageViewInterface {}
