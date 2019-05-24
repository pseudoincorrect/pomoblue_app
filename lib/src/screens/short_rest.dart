import 'package:flutter/material.dart';
import '../widgets/images_select.dart';
import '../widgets/home_timer.dart';

class ShortRestPage extends StatelessWidget {
  const ShortRestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTimer(
      imagesAssets: ImagesAssets(
        ready: 'assets/images/chair_ready.jpg',
        done: 'assets/images/chair_done.jpg',
        running: 'assets/images/relax_time.jpg',
      ),
      hideText: "Chill Time",
      backGroundColor: Color(0xff006b24),
    );
  }
}
