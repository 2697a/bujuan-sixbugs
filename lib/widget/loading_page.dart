import 'package:flutter/material.dart';


class LoadingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/loading.jpg',height: 100,),
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Text('数据加载中...',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }

}