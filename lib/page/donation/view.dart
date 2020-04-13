import 'package:bujuan/widget/bujuan_bottom_sheet.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(DonationState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text('捐赠作者'),
    ),
    body: ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            '本軟件的此次版本，是我比較滿意的版本，爲此下了不少功夫，項目的架構以及功能上的改進，都盡心盡力的做好，希望你們用的開心',
            style: TextStyle(height: 2),
          ),
        ),
        ListTile(
          title: Text('微信捐赠'),
          onTap: (){
            showPay(0, viewService);
          },
        ),
        ListTile(
          title: Text('支付宝捐赠'),
          onTap: (){
            showPay(1, viewService);
          },
        )
      ],
    ),
  );
}

void showPay(type, ViewService viewService) {
  var url = 'assets/images/wechat.png';
  if (type == 1) {
    url = 'assets/images/ali.jpg';
  }

  showBujuanBottomSheet(
    context: viewService.context,
    builder: (BuildContext context) {
      var width = MediaQuery.of(context).size.height;
      return Container(
        height: width,
        child: Image.asset(url),
      );
    },
  );
}
