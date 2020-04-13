import 'package:bujuan/page/bujuan_find/sheet/adapter.dart';
import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class SheetViewComponent extends Component<SheetViewState> {
  SheetViewComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<SheetViewState>(
              adapter: NoneConn<SheetViewState>() + SheetViewAdapter(),
              slots: <String, Dependent<SheetViewState>>{}),
        );
}
