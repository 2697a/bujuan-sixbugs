import 'dart:io';
import 'dart:ui';

import 'package:bujuan/constant/constants.dart';
import 'package:bujuan/global_store/action.dart';
import 'package:bujuan/global_store/store.dart';
import 'package:bujuan/widget/cache_image.dart';
import 'package:flutter/material.dart';
class BackSetting extends StatefulWidget{
  File file;
  BackSetting(this.file);
  @override
  State<StatefulWidget> createState() =>BackState();

}

class BackState extends State<BackSetting>{
  double blur;
  @override
  void initState() {
    blur = 2;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            child: ImageHelper.getImage(widget.file.path),
          ),
          BackdropFilter(
            filter:  ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child:  Container(
              color: Constants.dark?Colors.grey[850].withOpacity(0.5):Colors.white.withOpacity(0.5),
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(child: Container()),
              Container(
                color: Constants.dark?Colors.grey:Colors.white,
                child:  Column(
                  children: <Widget>[
                    Slider(
                      value: blur,
                      onChanged: (value) {
                        setState(() {
                          blur = value;
                        });
                      },
                      min: 0.0,
                      max: 10.0,
                      divisions: 10,
                      activeColor: Theme.of(context).accentColor,
                      inactiveColor: Theme.of(context).accentColor.withOpacity(0.3),
                    ),
                    MaterialButton(onPressed: (){
                      GlobalStore.store.dispatch(GlobalActionCreator.changeBack(widget.file.path));
                      GlobalStore.store.dispatch(GlobalActionCreator.changeBlur(blur));
                      Navigator.of(context).pop();
                    },child: Text('確定'),)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}