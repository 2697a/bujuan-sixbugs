import 'file:///C:/project/newPro/bujuan-sixbugs/lib/utils/net_utils.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SheetManagerState> buildEffect() {
  return combineEffects(<Object, Effect<SheetManagerState>>{
    SheetManagerAction.del: _onDel,
    SheetManagerAction.sub: _onSub
  });
}

void _onDel(Action action, Context<SheetManagerState> ctx) async{
  if(action.payload!=null){
    var index = action.payload;
    var bool = await NetUtils().delPlayList(ctx.state.createOrderList[index].id);
    if(bool) ctx.dispatch(SheetManagerActionCreator.onDelState(index));
  }
}

void _onSub(Action action, Context<SheetManagerState> ctx) async{
  if(action.payload!=null){
    var index = action.payload;
    var bool = await NetUtils().subPlaylist(false, ctx.state.orderList[index].id);
    if(bool) ctx.dispatch(SheetManagerActionCreator.onSubState(index));
  }
}
