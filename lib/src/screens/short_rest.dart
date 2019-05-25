import 'package:flutter/material.dart';
import '../bloc/timer/timer_provider.dart';
import '../widgets/images_select.dart';
import '../widgets/home_timer.dart';
import '../bloc/page_selector/active_page_provider.dart';
import '../bloc/which_page/which_page_provider.dart';

class ShortRestPage extends StatelessWidget {
  const ShortRestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimerBloc timerBloc = TimerBlocProvider.of(context);
    timerBloc.updateCounterResetVal(5 * 60);

    return WhichPageProvider(
      bloc: WhichPageBloc(myPage: Page.shortPause),
      child: HomeTimer(
        imagesAssets: ImagesAssets(
          ready: 'assets/images/chair_ready.jpg',
          done: 'assets/images/chair_done.jpg',
          running: 'assets/images/relax_time.jpg',
        ),
        hideText: "Chill Time",
        backGroundColor: Color(0xff006b24),
      ),
    );
  }
}
