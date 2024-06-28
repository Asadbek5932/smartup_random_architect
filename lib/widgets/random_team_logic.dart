import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/team.dart';
import 'generate_team.dart';

bool isNumberReady = true;

class RandomTeamLogic extends StatefulWidget {
  RandomTeamLogic({super.key, required this.myList});

  List<List<Team>> myList;

  @override
  State<RandomTeamLogic> createState() {
    return _RandomTeamLogicState();
  }
}

class _RandomTeamLogicState extends State<RandomTeamLogic> {
  void switchPlayersByLevelNumber(List<List<Team>> teams) {
    for (int i = 0; i < teams.length; i++) {
      for (int j = i + 1; j < teams.length; j++) {
        for (int m = 0; m < teams[i].length; m++) {
          for (int k = 0; k < teams[j].length; k++) {
            if (teams[i][m].levelNumber == teams[j][k].levelNumber) {
              var x = teams[i][m];
              teams[i][m] = teams[j][k];
              teams[j][k] = x;
              return;
            }
          }
        }
      }
    }
  }

  void loadTheScreen() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      isNumberReady = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isNumberReady = true;
    loadTheScreen();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.randomNumber),
        centerTitle: false,
      ),
      body: Center(
        child: isNumberReady
            ? GenerateTeam()
            : Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: widget.myList.length,
                  itemBuilder: (ctx, idx) {
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.randomGroup} ${idx + 1}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          for (var val in widget.myList[idx])
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    val.name,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(val.level)
                                ]),
                          const Divider()
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 35, top: 10),
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: screenWidth * 0.5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          color: Colors.pink,
                          child: Text(
                            AppLocalizations.of(context)!.back,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  Flexible(
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            isNumberReady = true;
                          });
                          widget.myList.shuffle();
                          switchPlayersByLevelNumber(widget.myList);
                          loadTheScreen();
                        },
                        child: Container(
                          width: screenWidth * 0.5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          color: Colors.green,
                          child: Text(
                            AppLocalizations.of(context)!.retry,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}