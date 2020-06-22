import 'package:bujuan/entity/user_order_entity.dart';
import 'package:bujuan/widget/slide_item.dart';
import 'package:fish_redux/fish_redux.dart';

class SheetManagerState implements Cloneable<SheetManagerState> {
  List<UserOrderPlaylist> createOrderList;
  List<UserOrderPlaylist> orderList;
  SlideConfig slideConfig;
  List<String> ids = [];

  @override
  SheetManagerState clone() {
    return SheetManagerState()
      ..createOrderList = createOrderList
      ..orderList = orderList
      ..ids = ids
      ..slideConfig = slideConfig;
  }
}

SheetManagerState initState(Map<String, dynamic> args) {
  var sheetManagerState = SheetManagerState();
  if (args != null) {
    sheetManagerState.createOrderList = args['create_list'];
    sheetManagerState.orderList = args['list'];
  }
  sheetManagerState.slideConfig = SlideConfig(
    slideOpenAnimDuration: Duration(milliseconds: 200),
    slideCloseAnimDuration: Duration(milliseconds: 100),
    deleteStep1AnimDuration: Duration(milliseconds: 50),
    deleteStep2AnimDuration: Duration(milliseconds: 30),
    supportElasticity: true,
    closeOpenedItemOnTouch: false,
    slideProportion: 0.2,
  );
  sheetManagerState.ids = [];
  return sheetManagerState;
}
