import 'package:flutter/material.dart';

class PomoTimer extends StatefulWidget {
  PomoTimer({Key key}) : super(key: key);

  _PomoTimerState createState() => _PomoTimerState();
}

class _PomoTimerState extends State<PomoTimer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Timer"),
      ),
    );
  }
}
