import 'package:flutter/material.dart';
import 'package:pomoblue/src/screens/long_rest.dart';
import '../screens/work.dart';
import '../screens/short_rest.dart';

class HomeTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('PomoBlue'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.rowing)),
              Tab(icon: Icon(Icons.airline_seat_legroom_extra)),
              Tab(icon: Icon(Icons.airline_seat_flat_angled)),
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
      ),
    );
  }
}
