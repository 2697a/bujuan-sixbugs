import 'dart:ui';

import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/search/action.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/widget/back_widget.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(SearchState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomPadding: false,
    body: Widgets.blackWidget(null, Container(
      child: Column(
        children: <Widget>[
          PreferredSize(child: Container(
            padding: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top+5,left: Screens.width5,right: Screens.width5),
            child:  Card(
              elevation: 2,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Container(width: Screens.setWidth(40),height: Screens.setHeight(40),child:  Icon(Icons.arrow_back,size: Screens.setSp(22),),),
                    onTap: ()=>Navigator.pop(viewService.context),
                  ),
//            IconButton(icon: Icon(Icons.arrow_back,size: Screens.setSp(22),), onPressed: ()=>Navigator.pop(viewService.context)),
                  Expanded(child: TextField(
                    controller: state.textEditingController,
                    textInputAction: TextInputAction.search,
                    maxLines: 1,
                    style: TextStyle(fontSize: Screens.text16),
                    decoration: InputDecoration(isDense: true, hintText: '请输入搜索内容', border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: Screens.setHeight(10), horizontal: Screens.setWidth(5))),
                    onSubmitted: (text) {
                      if (text != '')
                        dispatch(SearchActionCreator.doSearch(text));
                      else
                        BuJuanUtil.showToast('搜索内容不能为空');
                    },
                  ))
                ],
              ),
            ),
          ), preferredSize: Size.fromHeight(Screens.setHeight(54))),
          Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    title: Row(
                      children: <Widget>[
                        Text(
                          '${index + 1}. ',
                          style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Text(state.data[index].searchWord))
                      ],
                    ),
                    subtitle: Text(state.data[index].content),
                    onTap: () {
                      dispatch(SearchActionCreator.doSearch(state.data[index].searchWord));
                    },
                  );
                },
                itemCount: state.data.length,
              ))
        ],
      ),
    )),
  );
}
