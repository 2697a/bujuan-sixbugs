import 'dart:ui';

import 'package:bujuan/widget/bujuan_background.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    SheetInfoState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: IconButton(
                icon: Icon(Icons.keyboard_arrow_down,size: 28,),
                onPressed: () {
                  Navigator.pop(viewService.context);
                }),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: ImageHelper.getImage(
                state.playlist.coverImgUrl + "?param=500y500",
                height: MediaQuery.of(viewService.context).size.width - 30),
          ),
          Container(
            alignment: Alignment.center,
            child: InkWell(
              child: Container(
                padding:
                EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: Wrap(
                  children: <Widget>[
                    Text('保存封面'),
                  ],
                ),
              ),
              onTap: () {},
            ),
          ),
          Expanded(
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      state.playlist.description??'',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold, height: 1.5),
                    ),
                  )
                ],
              ))
        ],
      ),
    ),
  );
}
