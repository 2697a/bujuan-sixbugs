import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LocalMusicPage extends Page<LocalMusicState, Map<String, dynamic>> with KeepAliveMixin{
  LocalMusicPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LocalMusicState>(
                adapter: null,
                slots: <String, Dependent<LocalMusicState>>{
                }),
            middleware: <Middleware<LocalMusicState>>[
            ],);

}
