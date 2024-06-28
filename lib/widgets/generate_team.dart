import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GenerateTeam extends StatelessWidget {
  GenerateTeam({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 100,
          height: 100,
          child: const CircularProgressIndicator(
              backgroundColor: Colors.pinkAccent)),
    );
  }
}