import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchSongPage extends Page<SearchSongState, Map<String, dynamic>> {
  SearchSongPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SearchSongState>(
                adapter: null,
                slots: <String, Dependent<SearchSongState>>{
                }),
            middleware: <Middleware<SearchSongState>>[
            ],);

}
