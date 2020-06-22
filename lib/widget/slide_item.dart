//library slide_item;
//
//import 'dart:async';
//
//import 'package:flutter/material.dart';
//
//typedef ActionTapCallback = void Function(Slide item);
//
//const kDefaultAnimDuration = const Duration(milliseconds: 200);
//
//abstract class Slide {
//  void close();
//
//  Future delete([bool useAnim = true]);
//
//  int get indexInList;
//}
//
//enum _SlideItemStatus {
//  sliding,
//  opening,
//  closing,
//  opened,
//  closed,
//  deleting,
//}
//
//enum _SlideDirection {
//  ltr,
//  rtl,
//}
//
//class SlideAction {
//  bool isDeleteButton;
//  Widget actionWidget;
//  ActionTapCallback tapCallback;
//
//  SlideAction(
//      {this.actionWidget, this.tapCallback, this.isDeleteButton = false});
//}
//
//class SlideConfig extends ValueNotifier<int> {
//  int get nowSlidingIndex => value;
//
//  /// 是否支持弹性
//  final bool supportElasticity;
//
//  /// 已经打开的Item是否在触摸时直接关闭
//  final bool closeOpenedItemOnTouch;
//
//  /// 可滑动的比例
//  final double slideProportion;
//
//  /// 弹性效果的富余量
//  final double elasticityProportion;
//
//  /// Action自动打开动画触发的阈值比例
//  final double actionOpenThreshold;
//
//  /// 默认的Item背景
//  final Color backgroundColor;
//
//  /// 打开侧边菜单的动画持续时间
//  final Duration slideOpenAnimDuration;
//
//  /// 关闭侧边菜单的动画持续时间
//  final Duration slideCloseAnimDuration;
//
//  /// 删除的动画第一阶段（删除Action扩展为整个Item大小）持续时间
//  final Duration deleteStep1AnimDuration;
//
//  /// 删除的动画第一阶段（Item高度变化）持续时间
//  final Duration deleteStep2AnimDuration;
//
//  final Set<int> _openedSet = Set();
//
//  SlideConfig(
//      {this.slideCloseAnimDuration = kDefaultAnimDuration,
//      this.slideOpenAnimDuration = kDefaultAnimDuration,
//      this.deleteStep1AnimDuration = kDefaultAnimDuration,
//      this.deleteStep2AnimDuration = kDefaultAnimDuration,
//      this.closeOpenedItemOnTouch = false,
////      this.elasticityProportion = 0.1,
//        this.elasticityProportion = 0.0,
//      this.actionOpenThreshold = 0.5,
//      this.supportElasticity = true,
//      this.slideProportion = 0.25,
//      this.backgroundColor = Colors.white})
//      : assert(backgroundColor.value != Colors.transparent.value),
//        super(-1);
//
//  _openAt(int index) {
//    _openedSet.add(index);
//  }
//
//  _closeAt(int index) {
//    _openedSet.remove(index);
//  }
//
//  close() {
//    // 这里为了避免某些情况下多次修改这个值导致提前变成-1从而导致再调用此方法导致数值不变而
//    // 无法自动关闭，所以这里关闭后使其value多次变化同时由于监听了列表滚动，为了避免过度的
//    // 性能消耗，所以这里最多调用10次
//    if (value < 0 && value > -11 && _openedSet.length > 0) {
//      value = value--;
//    } else if (value > 0) {
//      value = -1;
//    }
//  }
//}
//
///// 对外暴露的Controller类，后续考虑加上打开、删除等控制操作
//class SlideController {
//  SlideConfig _config;
//
//  int get nowOpenedIndex => _config?.nowSlidingIndex ?? -1;
//
//  void close() {
//    _config?.close();
//  }
//
//  SlideController();
//}
//
///// 对外暴露的用于放在上层的提供配置信息以及共享菜单打开状态的Widget
//class SlideConfiguration extends StatelessWidget {
//  final SlideConfig config;
//  final Widget child;
//  final SlideController controller;
//
//  SlideConfiguration({Key key, this.config, this.child, this.controller})
//      : super(key: key) {
//    controller?._config = config;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return NotificationListener(
//      child: _ProviderWidget(
//        config: config,
//        child: child,
//      ),
//      onNotification: (_) {
//        config.close();
//        return false;
//      },
//    );
//  }
//}
//
//class _SlideConfigInheritedWidget extends InheritedWidget {
//  final SlideConfig config;
//  final int value;
//
//  const _SlideConfigInheritedWidget(
//    this.config,
//    this.value, {
//    Key key,
//    @required Widget child,
//  })  : assert(child != null),
//        super(key: key, child: child);
//
//  static SlideConfig of(BuildContext context, [bool listen = true]) {
//    return listen
//        ? context
//            .dependOnInheritedWidgetOfExactType<_SlideConfigInheritedWidget>()
//            .config
//        : (context
//                .getElementForInheritedWidgetOfExactType<
//                    _SlideConfigInheritedWidget>()
//                .widget as _SlideConfigInheritedWidget)
//            .config;
//  }
//
//  @override
//  bool updateShouldNotify(_SlideConfigInheritedWidget old) {
//    return old.value != value;
//  }
//}
//
//class _ProviderWidget extends StatefulWidget {
//  final SlideConfig config;
//  final Widget child;
//
//  const _ProviderWidget({Key key, this.config, this.child}) : super(key: key);
//
//  @override
//  _ProviderWidgetState createState() => _ProviderWidgetState();
//}
//
///// 模仿Provider的监听机制实现对Listenable数值的自动监听
//class _ProviderWidgetState extends State<_ProviderWidget> {
//  _update() {
//    setState(() {});
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    widget.config?.addListener(_update);
//  }
//
//  @override
//  void didUpdateWidget(_ProviderWidget oldWidget) {
//    if (oldWidget.config != widget.config) {
//      oldWidget.config?.removeListener(_update);
//      widget.config?.addListener(_update);
//    }
//    super.didUpdateWidget(oldWidget);
//  }
//
//  @override
//  void dispose() {
//    widget.config?.removeListener(_update);
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return _SlideConfigInheritedWidget(
//      widget.config,
//      widget.config.value,
//      child: widget.child,
//    );
//  }
//}
//
///// 缩小刷新范围的简单组件封装
//class _Consumer extends StatelessWidget {
//  _Consumer({
//    Key key,
//    @required this.builder,
//  })  : assert(builder != null),
//        super(key: key);
//
//  final Widget Function(BuildContext context, SlideConfig config) builder;
//
//  @override
//  Widget build(BuildContext context) {
//    return builder(
//      context,
//      _SlideConfigInheritedWidget.of(context),
//    );
//  }
//}
//
///// 因为一个Item划开菜单时其他item只需要拦截其自身的触摸事件，但是又由于关闭的监听在didChangeDependencies里面
///// 为了避免在build中启动动画导致build过程中调用build，这里封装一个暴露了disChangeDependencies的StatefulWidget
//class _StfulConsumer extends StatefulWidget {
//  final void Function(SlideConfig config) didChangeDependencies;
//  final Widget Function(BuildContext context, SlideConfig config) builder;
//
//  const _StfulConsumer({Key key, this.didChangeDependencies, this.builder})
//      : super(key: key);
//
//  @override
//  __StfulConsumerState createState() => __StfulConsumerState();
//}
//
//class __StfulConsumerState extends State<_StfulConsumer> {
//  @override
//  void didChangeDependencies() {
//    super.didChangeDependencies();
//    widget.didChangeDependencies?.call(_SlideConfigInheritedWidget.of(context));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return widget.builder(context, _SlideConfigInheritedWidget.of(context));
//  }
//}
//
///// 对外暴露的实现侧滑操作的Widget
//class SlideItem extends StatefulWidget {
//  final int indexInList;
//  final List<SlideAction> actions;
//  final List<SlideAction> leftActions;
//  final Widget child;
//  final bool slidable;
//
//  const SlideItem(
//      {Key key,
//      this.indexInList,
//      this.actions = const [],
//      this.child,
//      this.slidable = true,
//      this.leftActions = const []})
//      : assert(indexInList != null && indexInList >= 0),
//        assert((slidable && actions != null) || !slidable),
//        assert(child != null),
//        super(key: key);
//
//  @override
//  _SlideItemState createState() => _SlideItemState();
//}
//
//class _SlideItemState extends State<SlideItem>
//    with TickerProviderStateMixin
//    implements Slide {
//  int get actionCount => _direction != _SlideDirection.ltr
//      ? (widget.actions.length)
//      : (widget.leftActions.length);
//
//  bool get supportRightSlide => (widget.leftActions?.length ?? 0) > 0;
//
//  double get itemWidth => context?.size?.width ?? 1;
//
//  double get maxSlideProportion =>
//      actionCount *
//      ((_slideConfig.supportElasticity
//              ? _slideConfig.elasticityProportion
//              : 0.0) +
//          _slideConfig.slideProportion);
//
//  double get maxSlideTranslate => maxSlideProportion * context.size.width;
//
//  double get targetSlideProportion =>
//      _slideConfig.slideProportion * actionCount;
//
//  double get targetSlideTranslate => context.size.width * targetSlideProportion;
//
//  double translateValue = 0.0;
//
//  /// 如果在触摸时关闭了菜单，则不响应这次触摸事件，通过此变量来标记
//  bool closeByPanDown = false;
//  bool deleteSizeChange = false;
//
//  Size itemSize = Size.zero;
//
//  _SlideItemStatus _status = _SlideItemStatus.closed;
//  _SlideItemStatus _lastStatus = _SlideItemStatus.closing;
//
//  /// 因为direction有为null的情况，所以判断某个状态最好使用!=相反值来判断
//  _SlideDirection _direction;
//
//  SlideConfig _slideConfig;
//
//  AnimationController _slideController;
//  AnimationController _dismissController;
//
//  Animation<Offset> _slideAnimation;
//  Animation<Offset> _slideRightAnimation;
//  Animation<double> _dismissAnimation;
//
//  @override
//  void initState() {
//    super.initState();
//    _slideConfig = _SlideConfigInheritedWidget.of(context, false);
//    _slideController = AnimationController(
//        vsync: this, duration: _slideConfig.slideOpenAnimDuration);
//    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(-1, 0))
//        .animate(_slideController);
//    _slideRightAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(1, 0))
//        .animate(_slideController);
//
//    _dismissController = AnimationController(
//        vsync: this, duration: _slideConfig.deleteStep2AnimDuration);
//    _dismissAnimation =
//        Tween<double>(begin: 1.0, end: 0.0).animate(_dismissController);
//  }
//
//  @override
//  void dispose() {
//    _slideController.dispose();
//    _dismissController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    if (itemSize.height == 0) {
//      WidgetsBinding.instance.addPostFrameCallback((_) {
//        itemSize = context.size;
//      });
//    }
//    if (!widget.slidable ||
//        (widget.actions.isEmpty && widget.leftActions.isEmpty)) {
//      return _buildUnSlidableWidget();
//    }
//    return deleteSizeChange
//        ? _buildDeleteAnimWidget()
//        : _buildNormalSlideWidget();
//  }
//
//  // 避免除0
//  T _checkZero<T extends num>(T value) {
//    return value == 0 ? 1 : value;
//  }
//
//  @override
//  void close() {
//    _status = _SlideItemStatus.closing;
//    _lastStatus = _SlideItemStatus.closing;
//    if (_slideController.isAnimating) {
//      _slideController.stop();
//    }
//    // 根据剩余需要运动的比例来动态调整运动时间
//    _slideController
//        .animateTo(0,
//            duration: _slideConfig.slideCloseAnimDuration *
//                (_slideController.value / _checkZero(targetSlideProportion))
//                    .abs())
//        .whenComplete(() {
//      _slideConfig._closeAt(indexInList);
//      translateValue = 0.0;
//      _direction = null;
//      _status = _SlideItemStatus.closed;
//      if (_SlideConfigInheritedWidget.of(context, false).nowSlidingIndex ==
//          indexInList) {
//        _SlideConfigInheritedWidget.of(context, false).close();
//      }
//    });
//  }
//
//  @override
//  int get indexInList => widget.indexInList;
//
//  void _open() {
//    _status = _SlideItemStatus.opening;
//    _lastStatus = _SlideItemStatus.opening;
//    if (_slideController.isAnimating) {
//      _slideController.stop();
//    }
//    // 根据剩余需要运动的比例来动态调整运动时间
//    _slideController
//        .animateTo(targetSlideProportion,
//            curve: Curves.easeIn,
//            duration: _slideConfig.slideOpenAnimDuration *
//                (1.0 -
//                        _slideController.value /
//                            _checkZero(targetSlideProportion))
//                    .abs())
//        .whenComplete(() {
//      _slideConfig._openAt(indexInList);
//      _status = _SlideItemStatus.opened;
//      double absTv = translateValue.abs();
//      absTv = absTv == 0 ? 1 : absTv;
//      translateValue = (translateValue / absTv) * targetSlideTranslate;
//      _markSlidingItemIndex();
//    });
//  }
//
//  @override
//  Future delete([bool useAnim = true]) {
//    _status = _SlideItemStatus.deleting;
//    Completer completer = Completer();
//    var onAnimComplete = () {
//      // 动画执行完之后清除状态，避免后面组件复用出现问题
//      _status = _SlideItemStatus.closed;
//      _slideController.value = 0.0;
//      itemSize = Size.zero;
//      completer.complete();
//    };
//    if (useAnim) {
//      _slideController
//          .animateTo(1.0,
//              duration: _slideConfig.deleteStep1AnimDuration,
//              curve: Curves.easeIn)
//          .then((_) {
//        setState(() {
//          deleteSizeChange = true;
//        });
//        _dismissController.forward(from: 0.0).then((__) {
//          deleteSizeChange = false;
//          onAnimComplete.call();
//        });
//      });
//    } else {
//      onAnimComplete.call();
//    }
//    return completer.future;
//  }
//
//  Widget _buildDeleteAnimWidget() {
//    Widget deleteWidget;
//    var findDeleteAction = (actions) => actions?.forEach((a) {
//          assert(a != null);
//          if (a.isDeleteButton) {
//            deleteWidget = a.actionWidget;
//          }
//        });
//    if (_direction != _SlideDirection.ltr) {
//      findDeleteAction(widget.actions);
//    } else {
//      findDeleteAction(widget.leftActions);
//    }
//    if (deleteWidget == null) {
//      throw Exception('must have a delete widget when you call delete');
//    }
//    return SizeTransition(
//      axis: Axis.vertical,
//      sizeFactor: _dismissAnimation,
//      child: Material(
//        color: Colors.transparent,
//        child: SizedBox.fromSize(
//          size: itemSize,
//          child: deleteWidget,
//        ),
//      ),
//    );
//  }
//
//  Widget _buildNormalSlideWidget() {
//    return LayoutBuilder(
//      builder: (BuildContext layoutBuilderContext, BoxConstraints constraints) {
//        // 把处理Action手势的Widget提前封装好，避免频繁重建
//        List<Widget> actionList = _wrapActionGesture(widget.actions);
//        List<Widget> rightActionList = _wrapActionGesture(widget.leftActions);
//        return GestureDetector(
//          behavior: HitTestBehavior.opaque,
//          onHorizontalDragStart: _onDragStart,
//          onHorizontalDragUpdate: _onDragUpdate,
//          onHorizontalDragEnd: _onDragEnd,
//          onPanDown: (_) {
//            _onPanDown(_, constraints.maxWidth);
//          },
//          onTap: () {
//            close();
//          },
//          child: AnimatedBuilder(
//            animation: _slideAnimation,
//            builder: (_, __) {
//              double actionWidthWithoutElasticity =
//                  constraints.maxWidth * _slideConfig.slideProportion;
//              double actionNormalWidth = constraints.maxWidth *
//                  (_slideController.value > targetSlideProportion
//                      ? _slideController.value / actionCount
//                      : _slideConfig.slideProportion);
//              return _StfulConsumer(
//                didChangeDependencies: (config) {
//                  _slideConfig = config;
//                  if (config.nowSlidingIndex != indexInList &&
//                      _status != _SlideItemStatus.closed &&
//                      _status != _SlideItemStatus.sliding) close();
//                },
//                builder: (_, config) {
//                  return _SlideItemContainer(
//                    // 当有一个Item处于打开菜单状态时便需要屏蔽child的点击事件使其点击后只是关闭打开的Item
//                    absorbing: config.nowSlidingIndex >= 0 ||
//                        _status != _SlideItemStatus.closed,
//                    animation: _direction != _SlideDirection.ltr
//                        ? _slideAnimation
//                        : _slideRightAnimation,
//                    child: widget.child,
//                    action: _buildActions(
//                        actionList,
//                        widget.actions,
//                        _direction != _SlideDirection.ltr
//                            ? actionNormalWidth
//                            : actionWidthWithoutElasticity),
//                    leftAction: _buildActions(
//                        rightActionList,
//                        widget.leftActions,
//                        _direction != _SlideDirection.rtl
//                            ? actionNormalWidth
//                            : actionWidthWithoutElasticity),
//                  );
//                },
//              );
//            },
//          ),
//        );
//      },
//    );
//  }
//
//  List<Widget> _wrapActionGesture(List<SlideAction> actions) {
//    return actions
//        ?.map((action) => GestureDetector(
//              behavior: HitTestBehavior.translucent,
//              child: action.actionWidget,
//              onTap: () {
//                action.tapCallback?.call(this);
//              },
//            ))
//        ?.toList();
//  }
//
//  Widget _buildActions(List<Widget> actionList, List<SlideAction> actions,
//      double actionNormalWidth) {
//    int actionIndex = 0;
//    return Row(
//      mainAxisSize: MainAxisSize.min,
//      children: actionList.map((action) {
//        SlideAction sa = actions[actionIndex++];
//        double finallyActionWidth = actionNormalWidth;
//        // 为删除动画计算Action所需宽度（删除按钮跨度逐渐拉伸，其余按钮宽度压缩）
//        if (_status == _SlideItemStatus.deleting) {
//          // _slideController.value对于1的剩余量
//          double a = 1 - _slideController.value;
//          // 删除动画额外运动总量
//          double b = 1 - targetSlideProportion;
//          finallyActionWidth = (a / b) * actionNormalWidth;
//          if (sa.isDeleteButton) {
//            finallyActionWidth = actionNormalWidth * actionCount -
//                finallyActionWidth * (actionCount - 1);
//          }
//        }
//        return Container(
//          height: double.infinity,
//          child: action,
//          width: finallyActionWidth,
//        );
//      }).toList(),
//    );
//  }
//
//  Widget _buildUnSlidableWidget() {
//    return GestureDetector(
//      behavior: HitTestBehavior.opaque,
//      onPanDown: (_) {
//        _onPanDown(_, null);
//      },
//      onTap: () {
//        close();
//      },
//      child: _Consumer(
//        builder: (_, config) {
//          return AbsorbPointer(
//            child: widget.child,
//            absorbing: config.nowSlidingIndex >= 0,
//          );
//        },
//      ),
//    );
//  }
//
//  _onDragStart(_) {
//    if (_status != _SlideItemStatus.opening &&
//        _status != _SlideItemStatus.closing &&
//        !closeByPanDown) {
//      if (_status == _SlideItemStatus.closed) {
//        translateValue = 0;
//        _slideController.value = 0;
//        _direction = null;
//      }
//      _status = _SlideItemStatus.sliding;
//      _markSlidingItemIndex();
//    }
//  }
//
//  _onDragUpdate(DragUpdateDetails details) {
//    if (_status != _SlideItemStatus.sliding) {
//      return;
//    }
//    if (_slideController.isAnimating) {
//      _slideController.stop();
//    }
//    double newValue = translateValue + details.primaryDelta;
//    _direction = newValue > 0 ? _SlideDirection.ltr : _SlideDirection.rtl;
//
//    var checkDirection = (a1, a2) => a1.length > 0 && _direction == a2;
//
//    if (!checkDirection(widget.actions, _SlideDirection.rtl) &&
//        !checkDirection(widget.leftActions, _SlideDirection.ltr)) {
//      return;
//    }
//
//    if (newValue.abs() > targetSlideTranslate) {
//      // 滑动距离过量之后使其增速变缓
//      translateValue +=
//          (1 - newValue.abs() / maxSlideTranslate) * details.primaryDelta;
//    } else {
//      translateValue += details.primaryDelta;
//    }
//    _slideController.value = translateValue.abs() / itemWidth;
//    _markSlidingItemIndex();
//  }
//
//  _onDragEnd(_) {
//    closeByPanDown = false;
//    _markSlidingItemIndex();
//    double slideRatio = translateValue.abs() / targetSlideTranslate;
////    if (slideRatio < _slideConfig.actionOpenThreshold) {
////      close();
////    } else {
////      _open();
////    }
//    if(_lastStatus==_SlideItemStatus.closing){
//      if (slideRatio >= 0) {
//        _open();
//      }
//    } else if(_lastStatus==_SlideItemStatus.opening){
//      if (slideRatio < 1) {
//        close();
//      }
//    }
//  }
//
//  _onPanDown(DragDownDetails details, double maxWidth) {
//    closeByPanDown = false;
//    // 当触摸事件落在打开的action区域时不响应此事件，避免影响action的触摸事件
//    // 方向为空则说明此时没有打开Action，可以直接响应关闭事件
//    var compare = (a1, a2) =>
//        _direction == null ||
//        (_direction != null &&
//            a1 > _slideController.value &&
//            actionCount > 0 &&
//            a2);
//    bool notHitRightAction = maxWidth != null &&
//        compare((1 - details.localPosition.dx / maxWidth),
//            _direction != _SlideDirection.ltr);
//    bool notHitLeftAction = maxWidth != null &&
//        compare((details.localPosition.dx / maxWidth),
//            _direction != _SlideDirection.rtl);
//    if (maxWidth == null || notHitRightAction || notHitLeftAction) {
//      if (_status == _SlideItemStatus.opened) {
//        if (_slideConfig.closeOpenedItemOnTouch) {
//          closeByPanDown = true;
//          close();
//        }
//      } else {
//        _SlideConfigInheritedWidget.of(context, false).close();
//      }
//    }
//  }
//
//  /// 因为存在一个Item打开之后，拉开另一个Item的同时当前Item关闭，在关闭之后会将config中的
//  /// Index设为负数表示全部关闭，这样新拉开的就没办法关闭了，所以在能够标记当前Item状态的地方
//  /// 多次设置这个值，因为值没有变化不会引起重新构建，所以对性能消耗不大
//  _markSlidingItemIndex() {
//    _SlideConfigInheritedWidget.of(context, false).value = indexInList;
//  }
//}
//
//class _SlideItemContainer extends StatelessWidget {
//  final bool absorbing;
//  final Widget action;
//  final Widget leftAction;
//  final Widget child;
//  final Animation<Offset> animation;
//
//  const _SlideItemContainer({
//    Key key,
//    this.absorbing,
//    this.action,
//    this.animation,
//    this.child,
//    this.leftAction,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      fit: StackFit.loose,
//      children: <Widget>[
//        if (leftAction != null)
//          Positioned.fill(
//              child: Align(
//            child: leftAction,
//            alignment: Alignment.centerLeft,
//          )),
//        if (action != null)
//          Positioned.fill(
//              child: Align(
//            child: action,
//            alignment: Alignment.centerRight,
//          )),
//        SlideTransition(
//          position: animation,
//          child: AbsorbPointer(
//            child: Container(
//              child: child,
//              color: _SlideConfigInheritedWidget.of(context, false)
//                  .backgroundColor,
//            ),
//            absorbing: absorbing,
//          ),
//        )
//      ],
//    );
//  }
//}
library slide_item;

import 'dart:async';

import 'package:flutter/material.dart';

typedef ActionTapCallback = void Function(Slide item);

const kDefaultAnimDuration = const Duration(milliseconds: 200);

abstract class Slide {
  void close();

  Future delete([bool useAnim = true]);

  int get indexInList;
}

enum _SlideItemStatus {
  sliding,
  opening,
  closing,
  opened,
  closed,
  deleting,
}

enum _SlideDirection {
  ltr,
  rtl,
}

class SlideAction {
  bool isDeleteButton;
  Widget actionWidget;
  ActionTapCallback tapCallback;

  SlideAction(
      {this.actionWidget, this.tapCallback, this.isDeleteButton = false});
}

class SlideConfig extends ValueNotifier<int> {
  int get nowSlidingIndex => value;

  /// 是否支持弹性
  final bool supportElasticity;

  /// 已经打开的Item是否在触摸时直接关闭
  final bool closeOpenedItemOnTouch;

  /// 可滑动的比例
  double slideProportion;

  /// 可滑动的宽度（以上面的比例为准，如果两个参数都有的话）
  final double slideWidth;

  /// 弹性效果的富余量
  final double elasticityProportion;

  /// Action自动打开动画触发的阈值比例
  final double actionOpenCloseThreshold;

  /// 默认的Item背景
  final Color backgroundColor;

  /// 打开侧边菜单的动画持续时间
  final Duration slideOpenAnimDuration;

  /// 关闭侧边菜单的动画持续时间
  final Duration slideCloseAnimDuration;

  /// 删除的动画第一阶段（删除Action扩展为整个Item大小）持续时间
  final Duration deleteStep1AnimDuration;

  /// 删除的动画第一阶段（Item高度变化）持续时间
  final Duration deleteStep2AnimDuration;

  final Set<int> _openedSet = Set();

  SlideConfig(
      {this.slideCloseAnimDuration = kDefaultAnimDuration,
        this.slideOpenAnimDuration = kDefaultAnimDuration,
        this.deleteStep1AnimDuration = kDefaultAnimDuration,
        this.deleteStep2AnimDuration = kDefaultAnimDuration,
        this.closeOpenedItemOnTouch = false,
        this.elasticityProportion = 0.1,
        this.actionOpenCloseThreshold = 0.15,
        this.supportElasticity = true,
        this.slideProportion = 0.25,
        this.slideWidth,
        this.backgroundColor = Colors.white})
      : assert(backgroundColor.value != Colors.transparent.value),
        assert(slideProportion != null || slideWidth != null),
        super(-1);

  _openAt(int index) {
    _openedSet.add(index);
  }

  _closeAt(int index) {
    _openedSet.remove(index);
  }

  _close() {
    // 这里为了避免某些情况下多次修改这个值导致提前变成-1从而导致再调用此方法导致数值不变而
    // 无法自动关闭，所以这里关闭后使其value多次变化同时由于监听了列表滚动，为了避免过度的
    // 性能消耗，所以这里最多调用10次
    if (value < 0 && value > -11 && _openedSet.length > 0) {
      value = value--;
    } else if (value > 0) {
      value = -1;
    }
  }
}

/// 对外暴露的Controller类，后续考虑加上打开、删除等控制操作
class SlideController {
  SlideConfig _config;

  int get nowOpenedIndex => _config?.nowSlidingIndex ?? -1;

  void close() {
    _config?._close();
  }

  SlideController();
}

/// 对外暴露的用于放在上层的提供配置信息以及共享菜单打开状态的Widget
class SlideConfiguration extends StatefulWidget {
  final SlideConfig config;
  final Widget child;
  final SlideController controller;

  SlideConfiguration({Key key, this.config, this.child, this.controller})
      : super(key: key);

  @override
  _SlideConfigurationState createState() => _SlideConfigurationState();
}

class _SlideConfigurationState extends State<SlideConfiguration> {
  SlideConfig config;

  SlideController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _updateAndBindConfig();
  }

  @override
  void didUpdateWidget(SlideConfiguration oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (config != oldWidget.config) {
      SlideConfig sc = config;
      _updateAndBindConfig();
      config.value = sc.value;
      config._openedSet.addAll(sc._openedSet);
    }
  }

  void _updateAndBindConfig() {
    config = widget.config;
    if (config?.slideProportion != null && config.slideProportion > 0) {
      controller?._config = config;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (config?.slideWidth != null && config.slideWidth > 0) {
      return LayoutBuilder(
        builder: (_, cons) {
          config.slideProportion =
              config.slideWidth / cons.maxWidth;
          return buildListenerAndProvider(config);
        },
      );
    }
    return buildListenerAndProvider(config);
  }

  Widget buildListenerAndProvider(SlideConfig config) {
    return NotificationListener(
      child: _ProviderWidget(
        config: config,
        child: widget.child,
      ),
      onNotification: (_) {
        config?._close();
        return false;
      },
    );
  }
}

class _SlideConfigInheritedWidget extends InheritedWidget {
  final SlideConfig config;
  final int value;

  const _SlideConfigInheritedWidget(
      this.config,
      this.value, {
        Key key,
        @required Widget child,
      })  : assert(child != null),
        super(key: key, child: child);

  static SlideConfig of(BuildContext context, [bool listen = true]) {
    return listen
        ? context
        .dependOnInheritedWidgetOfExactType<_SlideConfigInheritedWidget>()
        .config
        : (context
        .getElementForInheritedWidgetOfExactType<
        _SlideConfigInheritedWidget>()
        .widget as _SlideConfigInheritedWidget)
        .config;
  }

  @override
  bool updateShouldNotify(_SlideConfigInheritedWidget old) {
    return old.value != value;
  }
}

class _ProviderWidget extends StatefulWidget {
  final SlideConfig config;
  final Widget child;

  const _ProviderWidget({Key key, this.config, this.child}) : super(key: key);

  @override
  _ProviderWidgetState createState() => _ProviderWidgetState();
}

/// 模仿Provider的监听机制实现对Listenable数值的自动监听
class _ProviderWidgetState extends State<_ProviderWidget> {
  _update() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.config?.addListener(_update);
  }

  @override
  void didUpdateWidget(_ProviderWidget oldWidget) {
    if (oldWidget.config != widget.config) {
      oldWidget.config?.removeListener(_update);
      widget.config?.addListener(_update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.config?.removeListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SlideConfigInheritedWidget(
      widget.config,
      widget.config?.value,
      child: widget.child,
    );
  }
}

/// 缩小刷新范围的简单组件封装
class _Consumer extends StatelessWidget {
  _Consumer({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  final Widget Function(BuildContext context, SlideConfig config) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      _SlideConfigInheritedWidget.of(context),
    );
  }
}

/// 因为一个Item划开菜单时其他item只需要拦截其自身的触摸事件，但是又由于关闭的监听在didChangeDependencies里面
/// 为了避免在build中启动动画导致build过程中调用build，这里封装一个暴露了disChangeDependencies的StatefulWidget
class _StfulConsumer extends StatefulWidget {
  final void Function(SlideConfig config) didChangeDependencies;
  final Widget Function(BuildContext context, SlideConfig config) builder;

  const _StfulConsumer({Key key, this.didChangeDependencies, this.builder})
      : super(key: key);

  @override
  __StfulConsumerState createState() => __StfulConsumerState();
}

class __StfulConsumerState extends State<_StfulConsumer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies?.call(_SlideConfigInheritedWidget.of(context));
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _SlideConfigInheritedWidget.of(context));
  }
}

/// 对外暴露的实现侧滑操作的Widget
class SlideItem extends StatefulWidget {
  final int indexInList;
  final List<SlideAction> actions;
  final List<SlideAction> leftActions;
  final Widget child;
  final bool slidable;

  const SlideItem(
      {Key key,
        this.indexInList,
        this.actions = const [],
        this.child,
        this.slidable = true,
        this.leftActions = const []})
      : assert(indexInList != null && indexInList >= 0),
        assert((slidable && actions != null) || !slidable),
        assert(child != null),
        super(key: key);

  @override
  _SlideItemState createState() => _SlideItemState();
}

class _SlideItemState extends State<SlideItem>
    with TickerProviderStateMixin
    implements Slide {
  int get actionCount => _direction != _SlideDirection.ltr
      ? (widget.actions.length)
      : (widget.leftActions.length);

  bool get supportRightSlide => (widget.leftActions?.length ?? 0) > 0;

  double get itemWidth => context?.size?.width ?? 1;

  double get maxSlideProportion =>
      actionCount *
          ((_slideConfig?.supportElasticity == true
              ? (_slideConfig?.elasticityProportion ?? 0)
              : 0.0) +
              (_slideConfig?.slideProportion ?? 0));

  double get maxSlideTranslate => maxSlideProportion * context.size.width;

  double get targetSlideProportion =>
      (_slideConfig?.slideProportion ?? 0) * actionCount;

  double get targetSlideTranslate => context.size.width * targetSlideProportion;

  double translateValue = 0.0;

  /// 如果在触摸时关闭了菜单，则不响应这次触摸事件，通过此变量来标记
  bool closeByPanDown = false;
  bool deleteSizeChange = false;

  Size itemSize = Size.zero;

  _SlideItemStatus _status = _SlideItemStatus.closed;
  _SlideItemStatus _statusAtDragStart;

  /// 因为direction有为null的情况，所以判断某个状态最好使用!=相反值来判断
  _SlideDirection _direction;

  SlideConfig _slideConfig;

  AnimationController _slideController;
  AnimationController _dismissController;

  Animation<Offset> _slideAnimation;
  Animation<Offset> _slideRightAnimation;
  Animation<double> _dismissAnimation;

  @override
  void initState() {
    super.initState();
    _slideConfig = _SlideConfigInheritedWidget.of(context, false);
    _slideController = AnimationController(
        vsync: this,
        duration: _slideConfig?.slideOpenAnimDuration ?? kDefaultAnimDuration);
    _slideAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(-1, 0))
        .animate(_slideController);
    _slideRightAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(1, 0))
        .animate(_slideController);

    _dismissController = AnimationController(
        vsync: this,
        duration:
        _slideConfig?.deleteStep2AnimDuration ?? kDefaultAnimDuration);
    _dismissAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_dismissController);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _dismissController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (itemSize.height == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        itemSize = context.size;
      });
    }
    if (!widget.slidable ||
        (widget.actions.isEmpty && widget.leftActions.isEmpty)) {
      return _buildUnSlidableWidget();
    }
    return deleteSizeChange
        ? _buildDeleteAnimWidget()
        : _buildNormalSlideWidget();
  }

  // 避免除0
  T _checkZero<T extends num>(T value) {
    return value == 0 ? 1 : value;
  }

  @override
  void close() {
    _status = _SlideItemStatus.closing;
    if (_slideController.isAnimating) {
      _slideController.stop();
    }
    // 根据剩余需要运动的比例来动态调整运动时间
    _slideController
        .animateTo(0,
        duration:
        (_slideConfig?.slideCloseAnimDuration ?? kDefaultAnimDuration) *
            (_slideController.value / _checkZero(targetSlideProportion))
                .abs())
        .whenComplete(() {
      _slideConfig?._closeAt(indexInList);
      translateValue = 0.0;
      _direction = null;
      _status = _SlideItemStatus.closed;
      if (_SlideConfigInheritedWidget.of(context, false).nowSlidingIndex ==
          indexInList) {
        _SlideConfigInheritedWidget.of(context, false)._close();
      }
    });
  }

  @override
  int get indexInList => widget.indexInList;

  void _open() {
    _status = _SlideItemStatus.opening;
    if (_slideController.isAnimating) {
      _slideController.stop();
    }
    // 根据剩余需要运动的比例来动态调整运动时间
    _slideController
        .animateTo(targetSlideProportion,
        curve: Curves.easeIn,
        duration:
        (_slideConfig?.slideOpenAnimDuration ?? kDefaultAnimDuration) *
            (1.0 -
                _slideController.value /
                    _checkZero(targetSlideProportion))
                .abs())
        .whenComplete(() {
      _slideConfig?._openAt(indexInList);
      _status = _SlideItemStatus.opened;
      double absTv = translateValue.abs();
      absTv = absTv == 0 ? 1 : absTv;
      translateValue = (translateValue / absTv) * targetSlideTranslate;
      _markSlidingItemIndex();
    });
  }

  @override
  Future delete([bool useAnim = true]) {
    _status = _SlideItemStatus.deleting;
    Completer completer = Completer();
    var onAnimComplete = () {
      // 动画执行完之后清除状态，避免后面组件复用出现问题
      _status = _SlideItemStatus.closed;
      _slideController.value = 0.0;
      itemSize = Size.zero;
      completer.complete();
    };
    if (useAnim) {
      _slideController
          .animateTo(1.0,
          duration:
          _slideConfig?.deleteStep1AnimDuration ?? kDefaultAnimDuration,
          curve: Curves.easeIn)
          .then((_) {
        setState(() {
          deleteSizeChange = true;
        });
        _dismissController.forward(from: 0.0).then((__) {
          deleteSizeChange = false;
          onAnimComplete.call();
        });
      });
    } else {
      onAnimComplete.call();
    }
    return completer.future;
  }

  Widget _buildDeleteAnimWidget() {
    Widget deleteWidget;
    var findDeleteAction = (actions) => actions?.forEach((a) {
      assert(a != null);
      if (a.isDeleteButton) {
        deleteWidget = a.actionWidget;
      }
    });
    if (_direction != _SlideDirection.ltr) {
      findDeleteAction(widget.actions);
    } else {
      findDeleteAction(widget.leftActions);
    }
    if (deleteWidget == null) {
      throw Exception('must have a delete widget when you call delete');
    }
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: _dismissAnimation,
      child: Material(
        color: Colors.transparent,
        child: SizedBox.fromSize(
          size: itemSize,
          child: deleteWidget,
        ),
      ),
    );
  }

  Widget _buildNormalSlideWidget() {
    return LayoutBuilder(
      builder: (BuildContext layoutBuilderContext, BoxConstraints constraints) {
        // 把处理Action手势的Widget提前封装好，避免频繁重建
        List<Widget> actionList = _wrapActionGesture(widget.actions);
        List<Widget> rightActionList = _wrapActionGesture(widget.leftActions);
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragStart: _onDragStart,
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          onPanDown: (_) {
            _onPanDown(_, constraints.maxWidth);
          },
          onTap: () {
            close();
          },
          child: AnimatedBuilder(
            animation: _slideAnimation,
            builder: (_, __) {
              double actionWidthWithoutElasticity =
                  constraints.maxWidth * (_slideConfig?.slideProportion ?? 0);
              double actionNormalWidth = constraints.maxWidth *
                  (_slideController.value > targetSlideProportion
                      ? _slideController.value / actionCount
                      : (_slideConfig?.slideProportion ?? 0));
              return _StfulConsumer(
                didChangeDependencies: (config) {
                  _slideConfig = config;
                  if (config?.nowSlidingIndex != indexInList &&
                      _status != _SlideItemStatus.closed &&
                      _status != _SlideItemStatus.sliding) close();
                },
                builder: (_, config) {
                  return _SlideItemContainer(
                    // 当有一个Item处于打开菜单状态时便需要屏蔽child的点击事件使其点击后只是关闭打开的Item
                    absorbing: (config?.nowSlidingIndex ?? -1) >= 0 ||
                        _status != _SlideItemStatus.closed,
                    animation: _direction != _SlideDirection.ltr
                        ? _slideAnimation
                        : _slideRightAnimation,
                    child: widget.child,
                    action: _buildActions(
                        actionList,
                        widget.actions,
                        _direction != _SlideDirection.ltr
                            ? actionNormalWidth
                            : actionWidthWithoutElasticity),
                    leftAction: _buildActions(
                        rightActionList,
                        widget.leftActions,
                        _direction != _SlideDirection.rtl
                            ? actionNormalWidth
                            : actionWidthWithoutElasticity),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> _wrapActionGesture(List<SlideAction> actions) {
    return actions
        ?.map((action) => GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: action.actionWidget,
      onTap: () {
        action.tapCallback?.call(this);
      },
    ))
        ?.toList();
  }

  Widget _buildActions(List<Widget> actionList, List<SlideAction> actions,
      double actionNormalWidth) {
    int actionIndex = 0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: actionList.map((action) {
        SlideAction sa = actions[actionIndex++];
        double finallyActionWidth = actionNormalWidth;
        // 为删除动画计算Action所需宽度（删除按钮跨度逐渐拉伸，其余按钮宽度压缩）
        if (_status == _SlideItemStatus.deleting) {
          // _slideController.value对于1的剩余量
          double a = 1 - _slideController.value;
          // 删除动画额外运动总量
          double b = 1 - targetSlideProportion;
          finallyActionWidth = (a / b) * actionNormalWidth;
          if (sa.isDeleteButton) {
            finallyActionWidth = actionNormalWidth * actionCount -
                finallyActionWidth * (actionCount - 1);
          }
        }
        return Container(
          margin: EdgeInsets.symmetric(vertical: 2),
          height: double.infinity,
          child: action,
          width: finallyActionWidth,
        );
      }).toList(),
    );
  }

  Widget _buildUnSlidableWidget() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        _onPanDown(_, null);
      },
      onTap: () {
        close();
      },
      child: _Consumer(
        builder: (_, config) {
          return AbsorbPointer(
            child: widget.child,
            absorbing: (config?.nowSlidingIndex ?? -1) >= 0,
          );
        },
      ),
    );
  }

  _onDragStart(_) {
    if (_status != _SlideItemStatus.opening &&
        _status != _SlideItemStatus.closing &&
        !closeByPanDown) {
      _statusAtDragStart = _status;
      if (_status == _SlideItemStatus.closed) {
        translateValue = 0;
        _slideController.value = 0;
        _direction = null;
      }
      _status = _SlideItemStatus.sliding;
      _markSlidingItemIndex();
    }
  }

  _onDragUpdate(DragUpdateDetails details) {
    if (_status != _SlideItemStatus.sliding) {
      return;
    }
    if (_slideController.isAnimating) {
      _slideController.stop();
    }
    double newValue = translateValue + details.primaryDelta;
    _direction = newValue > 0 ? _SlideDirection.ltr : _SlideDirection.rtl;

    var checkDirection = (a1, a2) => a1.length > 0 && _direction == a2;

    if (!checkDirection(widget.actions, _SlideDirection.rtl) &&
        !checkDirection(widget.leftActions, _SlideDirection.ltr)) {
      return;
    }

    if (newValue.abs() > targetSlideTranslate) {
      // 滑动距离过量之后使其增速变缓
      translateValue +=
          (1 - newValue.abs() / maxSlideTranslate) * details.primaryDelta;
    } else {
      translateValue += details.primaryDelta;
    }
    _slideController.value = translateValue.abs() / itemWidth;
    _markSlidingItemIndex();
  }

  _onDragEnd(_) {
    closeByPanDown = false;
    _markSlidingItemIndex();
    double slideRatio = translateValue.abs() / targetSlideTranslate;
    if (_statusAtDragStart == _SlideItemStatus.closed) {
      if (slideRatio >= (_slideConfig?.actionOpenCloseThreshold ?? 1) &&
          _status != _SlideItemStatus.closing) {
        _open();
      } else if (_status != _SlideItemStatus.opening) {
        close();
      }
    } else {
      double r = 1 - slideRatio;
      if (r >= (_slideConfig?.actionOpenCloseThreshold ?? 1) &&
          _status != _SlideItemStatus.opening) {
        close();
      } else if (_status != _SlideItemStatus.closing) {
        _open();
      }
    }
  }

  _onPanDown(DragDownDetails details, double maxWidth) {
    closeByPanDown = false;
    // 当触摸事件落在打开的action区域时不响应此事件，避免影响action的触摸事件
    // 方向为空则说明此时没有打开Action，可以直接响应关闭事件
    var compare = (a1, a2) =>
    _direction == null ||
        (_direction != null &&
            a1 > _slideController.value &&
            actionCount > 0 &&
            a2);
    bool notHitRightAction = maxWidth != null &&
        compare((1 - details.localPosition.dx / maxWidth),
            _direction != _SlideDirection.ltr);
    bool notHitLeftAction = maxWidth != null &&
        compare((details.localPosition.dx / maxWidth),
            _direction != _SlideDirection.rtl);
    if (maxWidth == null || notHitRightAction || notHitLeftAction) {
      if (_status == _SlideItemStatus.opened) {
        if (_slideConfig?.closeOpenedItemOnTouch == true) {
          closeByPanDown = true;
          close();
        }
      } else {
        _SlideConfigInheritedWidget.of(context, false)?._close();
      }
    }
  }

  /// 因为存在一个Item打开之后，拉开另一个Item的同时当前Item关闭，在关闭之后会将config中的
  /// Index设为负数表示全部关闭，这样新拉开的就没办法关闭了，所以在能够标记当前Item状态的地方
  /// 多次设置这个值，因为值没有变化不会引起重新构建，所以对性能消耗不大
  _markSlidingItemIndex() {
    _SlideConfigInheritedWidget.of(context, false)?.value = indexInList;
  }
}

class _SlideItemContainer extends StatelessWidget {
  final bool absorbing;
  final Widget action;
  final Widget leftAction;
  final Widget child;
  final Animation<Offset> animation;

  const _SlideItemContainer({
    Key key,
    this.absorbing,
    this.action,
    this.animation,
    this.child,
    this.leftAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: <Widget>[
        if (leftAction != null)
          Positioned.fill(
              child: Align(
                child: leftAction,
                alignment: Alignment.centerLeft,
              )),
        if (action != null)
          Positioned.fill(
              child: Align(
                child: action,
                alignment: Alignment.centerRight,
              )),
        SlideTransition(
          position: animation,
          child: AbsorbPointer(
            child: Container(
              child: child,
              color: _SlideConfigInheritedWidget.of(context, false)
                  ?.backgroundColor ??
                  Colors.red,
            ),
            absorbing: absorbing,
          ),
        )
      ],
    );
  }
}
