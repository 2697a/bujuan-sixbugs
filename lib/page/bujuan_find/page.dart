import 'package:bujuan/page/bujuan_find/banner/component.dart';
import 'package:bujuan/page/bujuan_find/new_song/component.dart';
import 'package:bujuan/page/bujuan_find/sheet/component.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class NewFindPage extends Page<NewFindState, Map<String, dynamic>>
    with KeepAliveMixin {
  NewFindPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<NewFindState>(
              adapter: null,
              slots: <String, Dependent<NewFindState>>{
                'banner': BannerConnector() + NewBannerComponent(),
                'sheet': SheetConnector() + SheetViewComponent(),
                'new_song': NewSongConnector() + NewSongComponent()
              }),
          middleware: <Middleware<NewFindState>>[],
        );
}
