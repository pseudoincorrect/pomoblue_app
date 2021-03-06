import 'package:flutter/material.dart';
import '../widgets/timer_pages.dart';
import 'bluetooth_devices_list.dart';

class HomeTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('PomoBlue'),
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 4, color: Colors.white),
            ),
            tabs: [
              Tab(
                child: tabTitle('Pomodoro'),
                icon: Icon(Icons.rowing),
              ),
              Tab(
                child: tabTitle('Short Break'),
                icon: Icon(Icons.airline_seat_legroom_extra),
              ),
              Tab(
                child: tabTitle('Long Break'),
                icon: Icon(Icons.airline_seat_flat_angled),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WorkPage(),
            ShortRestPage(),
            LongRestPage(),
          ],
        ),
//        floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.bluetooth),
//          onPressed: () => floatingButtonPressed(context),
//        ),
      ),
    );
  }

  Widget tabTitle(String textTab) {
    return Text(
      textTab,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 10),
    );
  }

  void floatingButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BluetoothDevicesList()),
    );
  }
}
