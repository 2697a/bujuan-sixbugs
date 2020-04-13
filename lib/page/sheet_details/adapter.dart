//import 'package:bujuan/page/sheet_details/sheet_details_item/component.dart';
//import 'package:bujuan/page/sheet_details/sheet_details_item/state.dart';
//import 'package:bujuan/page/sheet_details/state.dart';
//import 'package:fish_redux/fish_redux.dart';
//
//class SheetDetailsAdapterAdapter extends DynamicFlowAdapter<SheetDetailsState> {
//  SheetDetailsAdapterAdapter()
//      : super(
//          pool: <String, Component<Object>>{
//            "SheetDetailsItem": SheetDetailsItemComponent(),  //引用组件
//          },
//          connector: _SheetDetailsAdapterConnector(),
//          );
//}
//
//class _SheetDetailsAdapterConnector extends ConnOp<SheetDetailsState, List<ItemBean>> {
//  @override
//  List<ItemBean> get(SheetDetailsState state) {
//    //判断ListState里面的items数据是否为空
//    if (state.item?.isNotEmpty == true) {
//      //若不为空，把item数据转化成ItemBean的列表
//      return state.item
//          .map<ItemBean>((SheetDetailsItemState data) => ItemBean('SheetDetailsItem', data))
//          .toList(growable: true);
//    }else{
//      //若为空，返回空列表
//      return <ItemBean>[];
//    }
//  }
//
//  @override
//  void set(SheetDetailsState state, List<ItemBean> items) {
//    //把ItemBean的变化，修改到item的state的过程
//    if (items?.isNotEmpty == true) {
//      state.item = List<SheetDetailsItemState>.from(
//          items.map<SheetDetailsItemState>((ItemBean bean) => bean.data).toList());
//    } else {
//      state.item = <SheetDetailsItemState>[];
//    }
//  }
//
//  @override
//  subReducer(reducer) {
//    // TODO: implement subReducer
//    return super.subReducer(reducer);
//  }
//}
