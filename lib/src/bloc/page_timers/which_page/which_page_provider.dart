import 'package:flutter/material.dart';
import '../../page_timers/page_timers_bloc.dart';

class WhichPageBloc {
  final Pages myPage;
  WhichPageBloc({this.myPage});
}

class WhichPageProvider extends InheritedWidget {
  final WhichPageBloc bloc;

  WhichPageProvider({Key key, Widget child, this.bloc})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static WhichPageBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(WhichPageProvider)
            as WhichPageProvider)
        .bloc;
  }
}
