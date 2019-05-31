import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomoblue/src/bloc/page_timers/page_timers_provider.dart';
import './screens/home_tabs.dart';
import 'bloc/bluetooth/bluetooth_provider.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  PageTimersBloc pageTimersBloc;
  BluetoothBloc bluetoothBloc;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    preloadAssets(context);

    return PageTimersProvider(
      bloc: pageTimersBloc,
      child: BluetoothProvider(
        bloc: bluetoothBloc,
        child: MaterialApp(
          title: 'PomoBlue',
          theme: getTheme(),
          home: HomeTabs(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    pageTimersBloc = PageTimersBloc();
    bluetoothBloc = BluetoothBloc();
  }

  @override
  dispose() {
    super.dispose();
    bluetoothBloc?.dispose();
  }

  ThemeData getTheme() {
    return ThemeData(
      // Define the default Brightness and Colors
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      accentColor: Colors.blueAccent,
      fontFamily: '8BitsWonder',
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
