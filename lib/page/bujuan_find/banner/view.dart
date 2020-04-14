import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/page/bujuan_find/banner/action.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'state.dart';

Widget buildView(
    NewBannerState state, Dispatch dispatch, ViewService viewService) {
  return state.banners != null
      ? Container(
          margin: EdgeInsets.only(top: 3),
          child: Wrap(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(150),
                child: Swiper(
                  autoplay: true,
                  duration: 300,
                  autoplayDelay: 5000,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
//                    margin: EdgeInsets.only(bottom:Screens.height5),
                      child: ImageHelper.getImage(
                          state.banners[index].imageUrl + "?param=300y800"),
                    );
                  },
                  itemCount: state.banners.length,
                  viewportFraction: 1,
                  scale: 0.95,
                  onTap: (index) {
                    dispatch(
                        NewBannerActionCreator.onTap(state.banners[index]));
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: Screens.height10, horizontal: Screens.width5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _menuItem('Today', Icons.event, dispatch, MenuType.TODAY),
                    _menuItem(
                        '歌单', Icons.queue_music, dispatch, MenuType.SHEET),
                    _menuItem('歌手', Icons.people, dispatch, MenuType.SINGER),
                    _menuItem(
                        '电台', Icons.queue_music, dispatch, MenuType.RADIO),
                    _menuItem('Fm', Icons.video_library, dispatch, MenuType.FM),
                  ],
                ),
              ),
            ],
          ),
        )
      : Container();
}

Widget _menuItem(title, icon, dispatch, MenuType menuType) {
  return Column(
    children: <Widget>[
      Container(
        width: ScreenUtil().setWidth(44),
        decoration:
            BoxDecoration(color: Colors.amberAccent, shape: BoxShape.circle),
        child: IconButton(
            icon: Icon(icon),
            color: Colors.white,
            iconSize: ScreenUtil().setSp(20),
            onPressed: () {
              dispatch(NewBannerActionCreator.onOpenPage(menuType));
            }),
      ),
      Padding(padding: EdgeInsets.only(top: Screens.setHeight(5))),
      Text(
        title,
        style: TextStyle(fontSize: Screens.text12),
      )
    ],
  );
}
