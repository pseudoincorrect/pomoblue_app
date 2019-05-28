import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/page_timers/page_timers_provider.dart';
import 'package:pomoblue/src/bloc/page_timers/which_page/which_page_provider.dart';
import '../widgets/images_select.dart';
import '../widgets/home_timer.dart';

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
      ),
    );
  }
}

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
      ),
    );
  }
}

class LongRestPage extends StatelessWidget {
  const LongRestPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WhichPageBloc whichPageBloc = WhichPageBloc(myPage: Pages.longPause);
    return WhichPageProvider(
      bloc: whichPageBloc,
      child: HomeTimer(
        imagesAssets: ImagesAssets(
          ready: 'assets/images/travel_ready.jpg',
          done: 'assets/images/travel_done.jpg',
          running: 'assets/images/relax_time.jpg',
        ),
        hideText: "Chiller Time",
      ),
    );
  }
}
