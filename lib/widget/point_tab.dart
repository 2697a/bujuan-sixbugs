import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum PointTabIndicatorPosition { top, bottom }

class PointTabIndicator extends Decoration {
  const PointTabIndicator({
    this.color = Colors.black,
    this.insets = EdgeInsets.zero,
    this.position = PointTabIndicatorPosition.bottom,
  }) : assert(insets != null);

  final Color color;

  final EdgeInsetsGeometry insets;

  final PointTabIndicatorPosition position;

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is PointTabIndicator) {
      return PointTabIndicator(
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is PointTabIndicator) {
      return PointTabIndicator(
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _PointPainter createBoxPainter([VoidCallback onChanged]) {
    return _PointPainter(this, onChanged);
  }
}

class _PointPainter extends BoxPainter {
  _PointPainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  final PointTabIndicator decoration;

  Color get color => decoration.color;

  PointTabIndicatorPosition get position => decoration.position;

  EdgeInsetsGeometry get insets => decoration.insets;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    final Rect rect = offset & configuration.size;
    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawPoints(
        PointMode.points,
        [
          Offset(
              indicator.left + indicator.width / 2,
              position == PointTabIndicatorPosition.bottom
                  ? indicator.bottom
                  : indicator.top)
        ],
        paint);
  }
}