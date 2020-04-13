//
//import 'package:bujuan/page/today/state.dart';
//import 'package:bujuan/page/today/today_item/component.dart';
//import 'package:bujuan/page/today/today_item/state.dart';
//import 'package:fish_redux/fish_redux.dart';
//
//class TodayAdapterAdapter extends DynamicFlowAdapter<TodayState> {
//  TodayAdapterAdapter()
//      : super(
//          pool: <String, Component<Object>>{
//            "TodayItem": TodayItemComponent(),  //引用组件
//          },
//          connector: _TodayItemAdapterConnector(),
//          );
//}
//
//class _TodayItemAdapterConnector extends ConnOp<TodayState, List<ItemBean>> {
//  @override
//  List<ItemBean> get(TodayState state) {
//    //判断ListState里面的items数据是否为空
//    if (state.item?.isNotEmpty == true) {
//      //若不为空，把item数据转化成ItemBean的列表
//      return state.item
//          .map<ItemBean>((TodayItemState data) => ItemBean('TodayItem', data))
//          .toList(growable: true);
//    }else{
//      //若为空，返回空列表
//      return <ItemBean>[];
//    }
//  }
//
//  @override
//  void set(TodayState state, List<ItemBean> items) {
//    //把ItemBean的变化，修改到item的state的过程
//    if (items?.isNotEmpty == true) {
//      state.item = List<TodayItemState>.from(
//          items.map<TodayItemState>((ItemBean bean) => bean.data).toList());
//    } else {
//      state.item = <TodayItemState>[];
//    }
//  }
//
//  @override
//  subReducer(reducer) {
//    // TODO: implement subReducer
//    return super.subReducer(reducer);
//  }
//}
