import 'package:flutter/material.dart';
import 'package:pomoblue/src/bloc/timer/timer_bloc.dart';
import '../bloc/timer/timer_provider.dart';
import '../widgets/image_container.dart';

class ImagesAssets {
  final String ready;
  final String running;
  final String done;

  ImagesAssets({this.ready, this.running, this.done});
}

class ImagesSelect extends StatefulWidget {
  final ImagesAssets images;
  ImagesSelect({Key key, this.images}) : super(key: key);

  _ImagesSelectState createState() => _ImagesSelectState();
}

class _ImagesSelectState extends State<ImagesSelect> {
  TimerBloc timerBloc;

  @override
  Widget build(BuildContext context) {
    timerBloc = TimerBlocProvider.of(context);

    precacheImage(AssetImage(widget.images.ready), context);
    precacheImage(AssetImage(widget.images.running), context);
    precacheImage(AssetImage(widget.images.done), context);

    return StreamBuilder<TimerState>(
      stream: timerBloc.currentState,
      builder: (
        BuildContext context,
        AsyncSnapshot<TimerState> snapshot,
      ) {
        String photo;
        if (!snapshot.hasData) {
          photo = widget.images.ready;
        } else if (snapshot.data == TimerState.running ||
            snapshot.data == TimerState.paused) {
          photo = widget.images.running;
        } else if (snapshot.data == TimerState.done) {
          photo = widget.images.done;
        } else if (snapshot.data == TimerState.reset) {
          photo = widget.images.ready;
        }

        return ImageContainer(imageAsset: photo);
      },
    );
  }
}
