import 'package:flutter/material.dart';
import './page_selector_bloc.dart';
export './page_selector_bloc.dart';

class PageSelectoProvider extends InheritedWidget {
  final PageSelector bloc;

  PageSelectoProvider({Key key, Widget child})
      : bloc = PageSelector(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static PageSelector of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PageSelectoProvider)
            as PageSelectoProvider)
        .bloc;
  }
}
