import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SheetManagerState> buildReducer() {
  return asReducer(
    <Object, Reducer<SheetManagerState>>{
      SheetManagerAction.subState: subPlayList,
      SheetManagerAction.select: subSelect,
      SheetManagerAction.delState: delState
    },
  );
}


SheetManagerState subPlayList(SheetManagerState state, Action action) {
  final SheetManagerState newState = state.clone();
  newState.orderList.removeAt(action.payload);
  return newState;
}

SheetManagerState delState(SheetManagerState state, Action action) {
  final SheetManagerState newState = state.clone();
  newState.createOrderList.removeAt(action.payload);
  return newState;
}

SheetManagerState subSelect(SheetManagerState state, Action action) {
  final SheetManagerState newState = state.clone();
  if(newState.ids.contains(action.payload)){
    newState.ids.remove(action.payload);
  }else{
    newState.ids.add(action.payload);
  }
  return newState;
}
