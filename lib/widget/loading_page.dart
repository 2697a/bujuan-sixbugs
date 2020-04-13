import 'package:flutter/material.dart';

import 'color_loaed.dart';

class LoadingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColorLoader3(
        radius: 20.0,
        dotRadius: 3.0,
      ),
    );
  }

}