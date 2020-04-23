import 'package:bujuan/api/module.dart';
import 'package:bujuan/api/netease_cloud_music.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/log.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CloundPageState> buildEffect() {
  return combineEffects(<Object, Effect<CloundPageState>>{
//    CloundPageAction.action: _onAction,
    Lifecycle.initState:_onAction
  });
}

void _onAction(Action action, Context<CloundPageState> ctx) async{
  await _getUserCloud();
}


Future _getUserCloud()async{
  var answer = await user_cloud({},await BuJuanUtil.getCookie());
  LogUtil.init(isDebug: true);
  LogUtil.d('cloud====${answer.status}======${answer.body}');
  if(answer.status==200){
    var body = answer.body;
    var body2 = body['data'];

  }
}