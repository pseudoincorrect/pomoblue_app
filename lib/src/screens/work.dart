import 'package:flutter/material.dart';
import '../bloc/timer/timer_provider.dart';
import '../bloc/page_selector/active_page_provider.dart';
import '../bloc/which_page/which_page_provider.dart';
import '../widgets/home_timer.dart';
import '../widgets/images_select.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimerBloc timerBloc = TimerBlocProvider.of(context);
    timerBloc.updateCounterResetVal(25 * 60);

    return WhichPageProvider(
      bloc: WhichPageBloc(myPage: Page.work),
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
