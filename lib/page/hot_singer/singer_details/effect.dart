import 'package:bujuan/api/module.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SingerDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<SingerDetailsState>>{
    SingerDetailsAction.action: _onAction,
    Lifecycle.initState: _onInit
  });
}

void _onAction(Action action, Context<SingerDetailsState> ctx) async{
}

void _onInit(Action action, Context<SingerDetailsState> ctx) async{
  await _getSingerDetails(ctx.state.singerId);
}

Future _getSingerDetails(id) async{
  var answer = await artists({'id':id},BuJuanUtil.getCookie());
   if(answer.status==200){
     print('=======${answer.body}');
   }
}