import 'package:flutter/material.dart';
import '../widgets/images_select.dart';
import '../widgets/home_timer.dart';

class LongRestPage extends StatelessWidget {
  const LongRestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTimer(
      imagesAssets: ImagesAssets(
        ready: 'assets/images/travel_ready.jpg',
        done: 'assets/images/travel_done.jpg',
        running: 'assets/images/relax_time.jpg',
      ),
      hideText: "Chiller Time",
      backGroundColor: Color(0xff006b24),
    );
  }
}
