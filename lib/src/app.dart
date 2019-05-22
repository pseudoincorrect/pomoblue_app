import 'package:flutter/material.dart';
import './screens/home.dart';
import './bloc/timer/timer_provider.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimerBlocProvider(
      child: MaterialApp(
        title: 'Welcome to Flutter',
        theme: getTheme(),
        home: HomePage(),
      ),
    );
  }

  ThemeData getTheme() {
    return ThemeData(
      // Define the default Brightness and Colors
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      accentColor: Colors.blueAccent,
      fontFamily: '8BitsWonder',

      // textTheme: TextTheme(
      //   headline: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
      //   title: TextStyle(fontSize: 42.0, fontStyle: FontStyle.italic),
      //   body1: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
      // ),

      buttonTheme: ButtonThemeData(
        buttonColor: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
