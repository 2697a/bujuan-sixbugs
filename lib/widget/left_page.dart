import 'dart:io';
import 'dart:ui';

import 'package:bujuan/constant/Screens.dart';
import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/page/setting/setting.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'day_night_switch.dart';

const dayColor = Color(0xFFFFFFFF);
var nightColor = Color.fromRGBO(28, 28, 28, 1); //Color(0xFF1e2230);

class LeftPage extends StatefulWidget {
  final Widget child;

  LeftPage({
    this.child,
  });

  @override
  _LeftPageState createState() => _LeftPageState();
}

class _LeftPageState extends State<LeftPage>
    with SingleTickerProviderStateMixin {
  var val = false;
  var showSun = SpUtil.getBool(IS_SHOW_SUN, defValue: true);
  var isMiniNav = SpUtil.getBool(MINI_NAV, defValue: false);
  bool isBack;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    val = Constants.dark;
    isBack = SpUtil.getString(USER_BACKGROUND, defValue: null) != null;
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(seconds: 5),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          child: Widgets.blackWidget(
              isBack,
              Stack(
                children: <Widget>[
                  buildStar(top: Screens.setHeight(100), left: 40, val: val),
                  buildStar(top: Screens.setHeight(200), left: 80, val: val),
                  buildStar(top: Screens.setHeight(300), left: 10, val: val),
                  buildStar(top: Screens.setHeight(500), left: 100, val: val),
                  buildStar(top: Screens.setHeight(300), right: 40, val: val),
                  buildStar(top: Screens.setHeight(250), right: 100, val: val),
                  buildStar(top: Screens.setHeight(450), right: 80, val: val),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    height: Screens.setHeight(200),
                    child: Opacity(
                      opacity: val ? 0 : 1.0,
                      child: Image.asset(
                        'assets/images/cloud.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    height: Screens.setHeight(200),
                    child: Image.asset(
                      val
                          ? 'assets/images/mountain2_night.png'
                          : 'assets/images/mountain2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 0,
                    right: 0,
                    height: Screens.setHeight(140),
                    child: Image.asset(
                      val
                          ? 'assets/images/mountain_night.png'
                          : 'assets/images/mountain1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: -20,
                            right: 0,
                            left: 0,
                            child: Transform.translate(
                              offset: Offset(50 * _controller.value, 0),
                              child: Opacity(
                                opacity: val ? 0.0 : 0.8,
                                child: Image.asset(
                                  'assets/images/cloud2.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -20,
                            right: 0,
                            left: 0,
                            child: Transform.translate(
                              offset: Offset(100 * _controller.value, 0),
                              child: Opacity(
                                opacity: val ? 0.0 : 0.4,
                                child: Image.asset(
                                  'assets/images/cloud3.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(child: Container()),
                        ListTile(
                          title: Text(
                            '设置',
                            style: TextStyle(fontSize: 14),
                          ),
                          onTap: () async {
                            //打开设置
//                      await Navigator.of(context)
//                          .pushNamed('setting', arguments: null);
                            Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => SettingPage()))
                                .then((value) {
                              setState(() {
                                isBack = SpUtil.getString(USER_BACKGROUND,
                                        defValue: null) !=
                                    null;
                              });
                              GlobalStore.store.dispatch(
                                  GlobalActionCreator.onchangeThemeColor(
                                      false));
                            });
                          },
                        ),
                        SwitchListTile(
                            title: Text(
                              '迷你导航栏',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: isMiniNav,
                            onChanged: (value) {
                              setState(() {
                                isMiniNav = value;
                              });
                              SpUtil.putBool(MINI_NAV, value);
                            }),
                        SwitchListTile(
                            title: Text(
                              '开启顶部太阳',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: showSun,
                            onChanged: (value) {
                              setState(() {
                                showSun = value;
                              });
                              SpUtil.putBool(IS_SHOW_SUN, showSun);
                            }),
                        ListTile(
                          title: Text(
                            '主题切换',
                            style: TextStyle(fontSize: 14),
                          ),
                          trailing: DayNightSwitch(
                            value: val,
                            moonImage: AssetImage('assets/images/moon.png'),
                            onChanged: (value) {
//                              if (isBack) {
//                                BuJuanUtil.showToast('全局背景下不能切换主题');
//                              } else {
                                setState(() {
                                  val = value;
                                  Constants.dark = value;
                                  SpUtil.putBool('dark', value);
                                });
                                GlobalStore.store.dispatch(
                                    GlobalActionCreator.onchangeThemeColor(
                                        value));
//                              }
                            },
                          ),
                          onTap: () {
                            setState(() {
                              val = !val;
                              GlobalStore.store.dispatch(
                                  GlobalActionCreator.onchangeThemeColor(val));
                              Constants.dark = val;
                              SpUtil.putBool('dark', val);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: showSun
          ? Transform.translate(
              offset: Offset(140, 40),
              child: _buildFab(),
            )
          : null,
    );
  }

  Widget _buildFab() {
    return AnimatedBuilder(
      animation:
          CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildContainer(400 * _controller.value),
            _buildContainer(500 * _controller.value),
            _buildContainer(600 * _controller.value),
            Center(
              child: SizedBox(
                width: Screens.setHeight(256),
                height: Screens.setHeight(256),
                child: val
                    ? Image.asset('assets/images/moon.png')
                    : CircleAvatar(
                        backgroundColor: const Color(0xFFFDB813),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (val ? Colors.amber[100] : Colors.orangeAccent)
            .withOpacity(1 - _controller.value),
      ),
    );
  }

  buildStar({double top, double left, double right, bool val}) {
    return Positioned(
      top: top,
      right: right,
      left: left,
      child: Opacity(
        opacity: val ? 1 : 0,
        child: CircleAvatar(
          radius: 2,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
