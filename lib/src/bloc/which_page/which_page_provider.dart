import 'package:flutter/material.dart';
import '../page_selector/active_page_provider.dart';

class WhichPageBloc {
  final Page myPage;
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
