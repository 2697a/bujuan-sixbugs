import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SearchDetailsPage extends Page<SearchDetailsState, Map<String, dynamic>> with SingleTickerProviderMixin {
  SearchDetailsPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<SearchDetailsState>(adapter: null, slots: <String, Dependent<SearchDetailsState>>{}),
          middleware: <Middleware<SearchDetailsState>>[],
        );
}
