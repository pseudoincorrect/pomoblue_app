import 'package:flutter/material.dart';
import '../widgets/images_select.dart';
import '../widgets/home_timer.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeTimer(
      imagesAssets: ImagesAssets(
        ready: 'assets/images/work_ready.jpg',
        done: 'assets/images/work_done.jpg',
        running: 'assets/images/work_time.jpg',
      ),
      hideText: "Work Time",
      backGroundColor: Color(0xff0022900),
    );
  }
}
