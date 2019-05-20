import 'package:flutter/material.dart';

PreferredSizeWidget getAppBar(String title) {
  return AppBar(
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.settings),
        tooltip: 'settings',
        onPressed: () => print('hey man'),
      ),
    ],
    title: Text(
      title,
      style: TextStyle(fontSize: 26),
    ),
  );
}
