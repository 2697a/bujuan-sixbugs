import 'package:bujuan/net/net_utils.dart';
import 'package:flutter/material.dart';

class AddPlayListDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddPlayListState();
}

class AddPlayListState extends State<AddPlayListDialog> {
  TextEditingController _editingController = TextEditingController();
  bool isCreate = false;

  @override
  Widget build(BuildContext context) {
    Duration insetAnimationDuration = const Duration(milliseconds: 100);
    Curve insetAnimationCurve = Curves.decelerate;

    RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0)));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedPadding(
        padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
        duration: insetAnimationDuration,
        curve: insetAnimationCurve,
        child: MediaQuery.removeViewInsets(
          removeLeft: true,
          removeTop: true,
          removeRight: true,
          removeBottom: true,
          context: context,
          child: Center(
            child: Material(
              elevation: 24.0,
              color: Theme.of(context).dialogBackgroundColor,
              type: MaterialType.card,
              //在这里修改成我们想要显示的widget就行了，外部的属性跟其他Dialog保持一致
              child: !isCreate
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                          child: Text(
                            '新建歌单',
                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                          child: TextField(
                            controller: _editingController,
                            decoration: InputDecoration(
                              hintText: '请输入歌单名称',
                            ),
                            maxLines: 1,
                            maxLength: 20,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              MaterialButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('取消'),
                              ),
                              MaterialButton(
                                onPressed: () async => await _createPlaylist(),
                                child: Text('创建'),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: new Text("歌单创建中..."),
                          ),
                        ],
                      ),
                    ),
              shape: _defaultDialogShape,
            ),
          ),
        ),
      ),
    );
  }

  Future _createPlaylist() async {
    var name = _editingController.text;
    if (name != null) {
      setState(() => isCreate = true);
      var bool = await NetUtils().createPlaylist(name);
      if (bool)
        Navigator.of(context).pop(isCreate);
      else
        setState(() => isCreate = false);
    }
  }
}
