import 'package:bujuan/page/bujuan_find/sheet/sheet_item/component.dart';
import 'package:bujuan/page/bujuan_find/sheet/state.dart';
import 'package:fish_redux/fish_redux.dart';

class SheetViewAdapter extends DynamicFlowAdapter<SheetViewState> {
  SheetViewAdapter()
      : super(
          pool: <String, Component<Object>>{
            'top_sheet': TopSheetComponent(),
          },
          connector: _SheetViewConnector(),
          );
}

class _SheetViewConnector extends ConnOp<SheetViewState, List<ItemBean>> {
  @override
  List<ItemBean> get(SheetViewState state) {
    List<ItemBean> items = [];
    if (state.result == null) {
      return items;
    }
    state.result.forEach((sheet) {
      items.add(ItemBean('top_sheet', sheet));
    });
    return items;
  }

  @override
  void set(SheetViewState state, List<ItemBean> items) {
  }

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
