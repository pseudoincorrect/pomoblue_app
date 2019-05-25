import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/page_timers/page_timers_provider.dart';
import './widgets/home_tabs.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageTimersBloc = PageTimersBloc();
    preloadAssets(context);

    return PageTimersProvider(
      bloc: pageTimersBloc,
      child: MaterialApp(
        title: 'PomoBlue',
        theme: getTheme(),
        home: HomeTabs(),
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

  void preloadAssets(BuildContext context) {
    precacheImage(AssetImage('assets/images/work_ready.jpg'), context);
    precacheImage(AssetImage('assets/images/work_done.jpg'), context);
    precacheImage(AssetImage('assets/images/work_time.jpg'), context);
    precacheImage(AssetImage('assets/images/chair_ready.jpg'), context);
    precacheImage(AssetImage('assets/images/chair_done.jpg'), context);
    precacheImage(AssetImage('assets/images/relax_time.jpg'), context);
    precacheImage(AssetImage('assets/images/travel_ready.jpg'), context);
    precacheImage(AssetImage('assets/images/travel_done.jpg'), context);
    precacheImage(AssetImage('assets/images/relax_time.jpg'), context);
  }
}
