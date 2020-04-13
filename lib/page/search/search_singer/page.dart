import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchSingerPage extends Page<SearchSingerState, Map<String, dynamic>> {
  SearchSingerPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SearchSingerState>(
                adapter: null,
                slots: <String, Dependent<SearchSingerState>>{
                }),
            middleware: <Middleware<SearchSingerState>>[
            ],);

}
