import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';
enum MvTag{
  TJ,HOT,NEW,MORE
}
Widget buildView(MvState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          children: <Widget>[
            _mvTag(state,dispatch,viewService,MvTag.TJ, '精選'),
            _mvTag(state,dispatch,viewService,MvTag.HOT, '熱門'),
            _mvTag(state,dispatch,viewService,MvTag.NEW, '最新'),
            _mvTag(state,dispatch,viewService,MvTag.MORE, '更多'),
          ],
        )
      ],
    ),
  );
}
Widget _mvTag(MvState state, Dispatch dispatch, ViewService viewService,MvTag mvTag,title){
  return InkWell(
    child: Card(
      child: Container(
        padding: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
        child: Text(title,style: TextStyle(color: state.tag==mvTag?Colors.red:Colors.grey),),
      ),
    ),
    onTap: (){
      dispatch(MvActionCreator.onChangeTag(mvTag));
    },
  );
}