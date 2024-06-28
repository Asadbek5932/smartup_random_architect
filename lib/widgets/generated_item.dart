import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GeneratedItem extends StatelessWidget {
  GeneratedItem(
      {Key? key,
        required this.choosenItem,
        required this.numberIsReady,
        required this.listOfItems})
      : super(key: key);

  final String choosenItem;
  final bool numberIsReady;
  final List<String> listOfItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: numberIsReady
            ? Text(
          choosenItem,
          style: const TextStyle(
              color: Color.fromARGB(228, 56, 56, 157),
              fontWeight: FontWeight.normal,
              fontSize: 60),
          textAlign: TextAlign.center,
        )
            : Container(
          height: 80,
          width: 80,
          child: const CircularProgressIndicator(
              strokeWidth: 5,
              backgroundColor: Colors.pinkAccent),
        ),
      ),
    );
  }
}