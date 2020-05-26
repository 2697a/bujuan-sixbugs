import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EntranceState> buildReducer() {
  return asReducer(
    <Object, Reducer<EntranceState>>{
      EntranceAction.pageChange: _onPageChange,
      EntranceAction.miniNavBarSwitch: _onMiniNavBarSwitch,
      EntranceAction.changeDar: _onChangeDar,
      EntranceAction.changeBack:_onBlack
    },
  );
}


EntranceState _onPageChange(EntranceState state, Action action) {
  final int selectIndex = action.payload;
  if (state.selectIndex != selectIndex) {
    return state.clone()..selectIndex = selectIndex;
  }
  return state;
}


EntranceState _onMiniNavBarSwitch(EntranceState state, Action action) {
  var bool = SpUtil.getBool(MINI_NAV,defValue: false);
  if(bool!=state.miniNav){
    return state.clone()..miniNav = bool;
  }
  return state;
}
EntranceState _onBlack(EntranceState state, Action action) {
    return state.clone()..isBlack = SpUtil.getString(USER_BACKGROUND,defValue: null)!=null;
}
EntranceState _onChangeDar(EntranceState state, Action action) {
  final bool isDar = action.payload;
  return state.clone()..isDra = isDar;
}