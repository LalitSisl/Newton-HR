import 'package:flutter/material.dart';

Widget appbar(String title) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    leading: const Icon(
      Icons.arrow_back_ios,
      color: Color.fromARGB(255, 20, 20, 20),
      size: 18,
    ),
    title: Text(
      title,
      style:
          const TextStyle(fontSize: 18, color: Color.fromARGB(255, 20, 20, 20)),
    ),
  );
}
