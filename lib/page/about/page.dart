import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AboutPage extends Page<AboutState, Map<String, dynamic>> {
  AboutPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AboutState>(
                adapter: null,
                slots: <String, Dependent<AboutState>>{
                }),
            middleware: <Middleware<AboutState>>[
            ],);

}
