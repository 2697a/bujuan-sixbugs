import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AlbumDetailsPage extends Page<AlbumDetailsState, Map<String, dynamic>> {
  AlbumDetailsPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AlbumDetailsState>(
                adapter: null,
                slots: <String, Dependent<AlbumDetailsState>>{
                }),
            middleware: <Middleware<AlbumDetailsState>>[
            ],);

}
