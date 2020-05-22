import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/page/bujuan_find/banner/action.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'state.dart';

Widget buildView(
    NewBannerState state, Dispatch dispatch, ViewService viewService) {
  return state.banners != null
      ? Container(
          margin: EdgeInsets.only(top: 3),
          child: Column(
            children: <Widget>[
              Container(
                height: Screens.setHeight(136),
                child: Swiper(
                  autoplay: true,
                  duration: 500,
                  autoplayDelay: 4000,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: ImageHelper.getImage(
                          state.banners[index].imageUrl + "?param=300y800"),
                    );
                  },
                  itemCount: state.banners.length,
                  viewportFraction: 1,
                  scale: 0.8,
                  onTap: (index) {
                    dispatch(
                        NewBannerActionCreator.onTap(state.banners[index]));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: Screens.height15, horizontal: Screens.width5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _menuItem('Today', Icons.event, dispatch, MenuType.TODAY,viewService),
                    _menuItem(
                        '歌单', Icons.queue_music, dispatch, MenuType.SHEET,viewService),
                    _menuItem('歌手', Icons.people, dispatch, MenuType.SINGER,viewService),
                    _menuItem(
                        '电台', Icons.queue_music, dispatch, MenuType.RADIO,viewService),
                    _menuItem('Fm', Icons.video_library, dispatch, MenuType.FM,viewService),
                  ],
                ),
              ),
            ],
          ),
        )
      : Container();
}

Widget _menuItem(title, icon, dispatch, MenuType menuType,ViewService viewService) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(
        width: MediaQuery.of(viewService.context).size.width/8.6,
        decoration:
            BoxDecoration(color: Colors.amberAccent, shape: BoxShape.circle),
        child: IconButton(
            icon: Icon(icon),
            color: Colors.white,
            iconSize: MediaQuery.of(viewService.context).size.width/18,
            onPressed: () {
              dispatch(NewBannerActionCreator.onOpenPage(menuType));
            }),
      ),
      Padding(padding: EdgeInsets.only(top: Screens.setHeight(5))),
      Text(
        title,
        style: TextStyle(fontSize: Screens.text14),
      )
    ],
  );
}
