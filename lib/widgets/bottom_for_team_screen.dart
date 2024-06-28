import 'package:dev_kit/window/page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smartup_random_architect/bloc/third_screen_bloc/third_screen_event.dart';

import '../bloc/third_screen_bloc/third_screen_bloc.dart';
import '../models/team.dart';

class BottomForTeamScreen extends StatefulWidget {
  BottomForTeamScreen({
    Key? key,
    required this.bloc,
    required this.state,
  }) : super(key: key);

  final ThirdScreenBloc bloc;
  final PageState state;

  @override
  State<BottomForTeamScreen> createState() => _BottomForTeamScreenState();
}

class _BottomForTeamScreenState extends State<BottomForTeamScreen> {
  late String selectedValue;
  String anotherValue = 'Easy';
  bool isChanged = false;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> listOfItems = [
      AppLocalizations.of(context)!.easy,
      AppLocalizations.of(context)!.medium,
      AppLocalizations.of(context)!.hard
    ];
    selectedValue = AppLocalizations.of(context)!.easy;
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: TextFormField(
              controller: _textEditingController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.enterValue,
                hintStyle: const TextStyle(color: Colors.white60),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.enterValue;
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                child: DropdownButtonFormField<String>(
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  value: selectedValue,
                  dropdownColor: Colors.black45,
                  items: listOfItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      anotherValue = val!;
                      selectedValue = val!;
                      isChanged = true;
                    });
                  },
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: TextButton(
                    onPressed: () {
                      String enteredText = _textEditingController.text;
                      enteredText = enteredText.trim();
                      if (enteredText.isNotEmpty) {
                        final levelNumber = listOfItems
                            .indexOf(isChanged ? anotherValue : selectedValue);
                        final team = Team(
                          name: enteredText,
                          level: levelNumber == 0
                              ? listOfItems[0]
                              : levelNumber == 1
                                  ? listOfItems[1]
                                  : listOfItems[2],
                          levelNumber: levelNumber,
                        );
                        widget.bloc.add(ThirdScreenAddNewUserEvent(team: team));
                        _textEditingController.clear();
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.add,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.pink,
              child: TextButton(
                onPressed: () {
                  widget.bloc.add(ThirdScreenGenerateGroupsEvent(
                      context: context, bloc: widget.bloc));
                },
                child: Text(
                  AppLocalizations.of(context)!.generate,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
