import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneratedNumber extends StatelessWidget {
  GeneratedNumber({
    Key? key,
    required this.generatedNumber,
    required this.numberIsReady,
  }) : super(key: key);

  final int generatedNumber;
  final bool numberIsReady;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Center(
        child: numberIsReady
            ? Text(
          generatedNumber.toString() == "-1"
              ? 'Enter valid number'
              : generatedNumber.toString(),
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: generatedNumber == -1 ? 28 : 70),
        )
            : const CircularProgressIndicator(
            backgroundColor: Colors.pinkAccent),
      ),
    );
  }
}