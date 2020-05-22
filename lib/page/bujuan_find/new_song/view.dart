import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/page/bujuan_find/new_song/action.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    NewSongState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: state.result != null
        ? Wrap(
            children: <Widget>[
              Offstage(
                offstage: state.result.length == 0,
                child: Container(
                  child: Text(
                    '新歌放送',
                    style:
                        TextStyle(fontSize: Screens.text14, fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.only(bottom: 15,left: Screens.width5),
                ),
              ),
              Container(
                height: Screens.setHeight(135),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Wrap(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Container(
                            width: Screens.setHeight(100),
                            height: Screens.setHeight(100),
                            margin: EdgeInsets.only(right: Screens.width10),
                            child: ImageHelper.getImage(
                                state.result[index].picUrl + "?param=220y220",
                                height: Screens.setHeight(100)),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: BoxConstraints(maxWidth: Screens.setHeight(100)),
                            height: Screens.setHeight(30),
                            child: Text(
                              ' ${state.result[index].name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        dispatch(
                            NewSongActionCreator.onPlay(index));
                      },
                    );
                  },
                  itemCount: state.result.length,
                ),
              )
            ],
          )
        : Container(),
  );
}
