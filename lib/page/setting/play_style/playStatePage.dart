import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Page;
import 'package:flutter/widgets.dart';

class PlayStylePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>PlayStyleState();

}


class PlayStyleState extends State{
  List<String> _images = [];
  PageController _pageController = PageController(initialPage: 0,viewportFraction: .7);
  @override
  void initState() {
    _images.add('assets/images/round.jpg');
    _images.add('assets/images/rect.jpg');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(child: PageView.builder(itemBuilder: (context,index){
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(8.0)
              ),
              margin: EdgeInsets.only(right: 20,bottom: 20),
              child: Image.asset(_images[index]),
            );
          },itemCount: _images.length,controller: _pageController,onPageChanged: (index){

          },),flex: 3),
          Expanded(child: Container(),flex: 1)
        ],
      ),
    );
  }

}