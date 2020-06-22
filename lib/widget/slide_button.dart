import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SlideButton extends StatefulWidget {
  Widget child;
  List<Widget> buttons;
  GlobalKey<SlideButtonState> key;
  double singleButtonWidth;

  VoidCallback onSlideStarted;

  VoidCallback onSlideCompleted;

  VoidCallback onSlideCanceled;

  SlideButton(
      {this.key,
        @required this.child,
        @required this.singleButtonWidth,
        @required this.buttons,
        this.onSlideStarted,
        this.onSlideCompleted,
        this.onSlideCanceled})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SlideButtonState();
  }
}

class SlideButtonState extends State<SlideButton>
    with TickerProviderStateMixin {
  double translateX = 0;
  double maxDragDistance;
  final Map<Type, GestureRecognizerFactory> gestures =
  <Type, GestureRecognizerFactory>{};

  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    maxDragDistance = widget.singleButtonWidth * widget.buttons.length;
    gestures[HorizontalDragGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
              () => HorizontalDragGestureRecognizer(debugOwner: this),
              (HorizontalDragGestureRecognizer instance) {
            instance
              ..onDown = onHorizontalDragDown
              ..onUpdate = onHorizontalDragUpdate
              ..onEnd = onHorizontalDragEnd;
          },
        );
    animationController = AnimationController(
        lowerBound: -maxDragDistance,
        upperBound: 0,
        vsync: this,
        duration: Duration(milliseconds: 300))
      ..addListener(() {
        translateX = animationController.value;
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Stack(
      children: <Widget>[
        Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: widget.buttons,
            )),
        RawGestureDetector(
          gestures: gestures,
          child: Transform.translate(
            offset: Offset(translateX, 0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: widget.child,
                )
              ],
            ),
          ),
        )
      ],
    ), onWillPop: ()async{
      if (translateX != 0){
        close();
        return false;
      }
      return true;
    });
  }

  void onHorizontalDragDown(DragDownDetails details) {
    if (widget.onSlideStarted != null) widget.onSlideStarted.call();
  }

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    translateX = (translateX + details.delta.dx).clamp(-maxDragDistance, 0.0);
    setState(() {});
  }

  void onHorizontalDragEnd(DragEndDetails details) {
    animationController.value = translateX;
    if (details.velocity.pixelsPerSecond.dx > 200) {
      close();
    } else if (details.velocity.pixelsPerSecond.dx < -200) {
      open();
    } else {
      if (translateX.abs() > maxDragDistance / 2) {
        open();
      } else {
        close();
      }
    }
  }

  void open() {
    if (translateX != -maxDragDistance)
      animationController.animateTo(-maxDragDistance).then((_) {
        if (widget.onSlideCompleted != null) widget.onSlideCompleted.call();
      });
  }

  void close() {
    if (translateX != 0)
      animationController.animateTo(0).then((_) {
        if (widget.onSlideCanceled != null) widget.onSlideCanceled.call();
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}