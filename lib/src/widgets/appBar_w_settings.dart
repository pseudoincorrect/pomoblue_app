import 'package:flutter/material.dart';

PreferredSizeWidget getAppBar(String title, double textSize) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(fontSize: textSize),
    ),
  );
}
