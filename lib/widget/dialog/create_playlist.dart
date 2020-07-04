import 'file:///C:/project/newPro/bujuan-sixbugs/lib/utils/net_utils.dart';
import 'package:bujuan/utils/bujuan_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePlayListDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DialogState();
}

class _DialogState extends State<CreatePlayListDialog> {
  bool isCreate = false;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * .8;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8.0)),
          width: width,
          child: isCreate?Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: width,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 45,
                  width: 45,
                  child: CircularProgressIndicator(),
                )
              ],
            ),
          ):Wrap(
            direction: Axis.vertical,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text('创建歌单', style: TextStyle(fontSize: 16))),
              Container(
                width: width,
                height: 30,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: TextField(
                  controller: textEditingController,
                  autofocus: true,
                ),
              ),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text('取消'),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('创建'),
                      onPressed: () async{
                        if(textEditingController.text!=''){
                          setState(() {
                            isCreate = true;
                          });
                          var bool = await NetUtils().createPlayList(textEditingController.text);
                          Navigator.of(context).pop(bool);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
