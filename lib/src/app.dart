import 'package:flutter/material.dart';
import './screens/home.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: getTheme(),
      home: HomePage(),
    );
  }

  ThemeData getTheme() {
    return ThemeData(
      // Define the default Brightness and Colors
      brightness: Brightness.dark,
      primaryColor: Colors.green,
      accentColor: Colors.greenAccent,

      // Define the default Font Family
      fontFamily: 'ConcertOne',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 42.0, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
      ),
    );
  }
}
