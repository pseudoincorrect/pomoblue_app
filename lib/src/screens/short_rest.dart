import 'package:flutter/material.dart';
import '../widgets/images_select.dart';
import '../widgets/home_timer.dart';
import 'package:pomoblue/src/bloc/page_timers/page_timers_provider.dart';
import 'package:pomoblue/src/bloc/page_timers/which_page/which_page_provider.dart';

class ShortRestPage extends StatelessWidget {
  const ShortRestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WhichPageBloc whichPageBloc = WhichPageBloc(myPage: Pages.shortPause);

    return WhichPageProvider(
      bloc: whichPageBloc,
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
