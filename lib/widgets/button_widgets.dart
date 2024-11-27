import 'package:flutter/material.dart';

Widget buttonElevatedWithExpand(String title, Function callback) {
  return Expanded(
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
      onPressed: () {
        callback();
      },
      child: Text(title),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget button_ElevatedDynamic(String title, Function callback) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
      onPressed: () {
        callback();
      },
      child: Text(title),
    ),
  );
}

Widget buttonElevated(String title, Function callback) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
    ),
    onPressed: () {
      callback();
    },
    child: Text(title),
  );
}
