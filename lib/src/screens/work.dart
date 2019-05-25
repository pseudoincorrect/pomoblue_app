import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/page_timers/page_timers_provider.dart';
import '../widgets/home_timer.dart';
import '../widgets/images_select.dart';
import 'package:pomoblue/src/bloc/page_timers/which_page/which_page_provider.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WhichPageBloc whichPageBloc = WhichPageBloc(myPage: Pages.work);

    return WhichPageProvider(
      bloc: whichPageBloc,
      child: HomeTimer(
        imagesAssets: ImagesAssets(
          ready: 'assets/images/work_ready.jpg',
          done: 'assets/images/work_done.jpg',
          running: 'assets/images/work_time.jpg',
        ),
        hideText: "Work Time",
        backGroundColor: Color(0xff0022900),
      ),
    );
  }
}
