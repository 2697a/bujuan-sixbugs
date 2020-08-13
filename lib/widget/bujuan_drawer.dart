// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;


/// The possible alignments of a [BujuanDrawer].
enum DrawerAlignment {
  /// Denotes that the [BujuanDrawer] is at the start side of the [Scaffold].
  ///
  /// This corresponds to the left side when the text direction is left-to-right
  /// and the right side when the text direction is right-to-left.
  start,

  /// Denotes that the [BujuanDrawer] is at the end side of the [Scaffold].
  ///
  /// This corresponds to the right side when the text direction is left-to-right
  /// and the left side when the text direction is right-to-left.
  end,
}

// TODO(eseidel): Draw width should vary based on device size:
// https://material.io/design/components/navigation-drawer.html#specs

// Mobile:
// Width = Screen width − 56 dp
// Maximum width: 320dp
// Maximum width applies only when using a left nav. When using a right nav,
// the panel can cover the full width of the screen.

// Desktop/Tablet:
// Maximum width for a left nav is 400dp.
// The right nav can vary depending on content.

const double _kWidth = 304.0;
const double _kEdgeDragWidth = 20.0;
const double _kMinFlingVelocity = 365.0;
const Duration _kBaseSettleDuration = Duration(milliseconds: 246);

/// A material design panel that slides in horizontally from the edge of a
/// [Scaffold] to show navigation links in an application.
///
/// Drawers are typically used with the [Scaffold.drawer] property. The child of
/// the drawer is usually a [ListView] whose first child is a [DrawerHeader]
/// that displays status information about the current user. The remaining
/// drawer children are often constructed with [ListTile]s, often concluding
/// with an [AboutListTile].
///
/// The [AppBar] automatically displays an appropriate [IconButton] to show the
/// [BujuanDrawer] when a [BujuanDrawer] is available in the [Scaffold]. The [Scaffold]
/// automatically handles the edge-swipe gesture to show the drawer.
///
/// {@animation 350 622 https://flutter.github.io/assets-for-api-docs/assets/material/drawer.mp4}
///
/// {@tool snippet}
/// This example shows how to create a [Scaffold] that contains an [AppBar] and
/// a [BujuanDrawer]. A user taps the "menu" icon in the [AppBar] to open the
/// [BujuanDrawer]. The [BujuanDrawer] displays four items: A header and three menu items.
/// The [BujuanDrawer] displays the four items using a [ListView], which allows the
/// user to scroll through the items if need be.
///
/// ```dart
/// Scaffold(
///   appBar: AppBar(
///     title: const Text('Drawer Demo'),
///   ),
///   drawer: Drawer(
///     child: ListView(
///       padding: EdgeInsets.zero,
///       children: const <Widget>[
///         DrawerHeader(
///           decoration: BoxDecoration(
///             color: Colors.blue,
///           ),
///           child: Text(
///             'Drawer Header',
///             style: TextStyle(
///               color: Colors.white,
///               fontSize: 24,
///             ),
///           ),
///         ),
///         ListTile(
///           leading: Icon(Icons.message),
///           title: Text('Messages'),
///         ),
///         ListTile(
///           leading: Icon(Icons.account_circle),
///           title: Text('Profile'),
///         ),
///         ListTile(
///           leading: Icon(Icons.settings),
///           title: Text('Settings'),
///         ),
///       ],
///     ),
///   ),
/// )
/// ```
/// {@end-tool}
///
/// An open drawer can be closed by calling [Navigator.pop]. For example
/// a drawer item might close the drawer when tapped:
///
/// ```dart
/// ListTile(
///   leading: Icon(Icons.change_history),
///   title: Text('Change history'),
///   onTap: () {
///     // change app state...
///     Navigator.pop(context); // close the drawer
///   },
/// );
/// ```
///
/// See also:
///
///  * [Scaffold.drawer], where one specifies a [BujuanDrawer] so that it can be
///    shown.
///  * [Scaffold.of], to obtain the current [ScaffoldState], which manages the
///    display and animation of the drawer.
///  * [ScaffoldState.openDrawer], which displays its [BujuanDrawer], if any.
///  * <https://material.io/design/components/navigation-drawer.html>
class BujuanDrawer extends StatelessWidget {
  /// Creates a material design drawer.
  ///
  /// Typically used in the [Scaffold.drawer] property.
  ///
  /// The [elevation] must be non-negative.
  const BujuanDrawer({
    Key key,
    this.elevation = 16.0,
    this.child,
    this.semanticLabel,
  }) : assert(elevation != null && elevation >= 0.0),
       super(key: key);

  /// The z-coordinate at which to place this drawer relative to its parent.
  ///
  /// This controls the size of the shadow below the drawer.
  ///
  /// Defaults to 16, the appropriate elevation for drawers. The value is
  /// always non-negative.
  final double elevation;

  /// The widget below this widget in the tree.
  ///
  /// Typically a [SliverList].
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the drawer is opened and closed.
  ///
  /// If this label is not provided, it will default to
  /// [MaterialLocalizations.drawerLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.namesRoute], for a description of how this
  ///    value is used.
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    String label = semanticLabel;
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        label = semanticLabel;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        label = semanticLabel ?? MaterialLocalizations.of(context)?.drawerLabel;
    }
    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      label: label,
      child: ConstrainedBox(
        constraints:  BoxConstraints.expand(width: MediaQuery.of(context).size.width*.8),
        child: Material(
          elevation: elevation,
          child: child,
        ),
      ),
    );
  }
}

/// Signature for the callback that's called when a [DrawerController] is
/// opened or closed.
typedef DrawerCallback = void Function(bool isOpened);

/// Provides interactive behavior for [BujuanDrawer] widgets.
///
/// Rarely used directly. Drawer controllers are typically created automatically
/// by [Scaffold] widgets.
///
/// The draw controller provides the ability to open and close a drawer, either
/// via an animation or via user interaction. When closed, the drawer collapses
/// to a translucent gesture detector that can be used to listen for edge
/// swipes.
///
/// See also:
///
///  * [BujuanDrawer], a container with the default width of a drawer.
///  * [Scaffold.drawer], the [Scaffold] slot for showing a drawer.
class DrawerController extends StatefulWidget {
  /// Creates a controller for a [BujuanDrawer].
  ///
  /// Rarely used directly.
  ///
  /// The [child] argument must not be null and is typically a [BujuanDrawer].
  const DrawerController({
    GlobalKey key,
    @required this.child,
    @required this.alignment,
    this.drawerCallback,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrimColor,
    this.edgeDragWidth,
    this.enableOpenDragGesture = true,
  }) : assert(child != null),
       assert(dragStartBehavior != null),
       assert(alignment != null),
       super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// Typically a [BujuanDrawer].
  final Widget child;

  /// The alignment of the [BujuanDrawer].
  ///
  /// This controls the direction in which the user should swipe to open and
  /// close the drawer.
  final DrawerAlignment alignment;

  /// Optional callback that is called when a [BujuanDrawer] is opened or closed.
  final DrawerCallback drawerCallback;

  /// {@template flutter.material.drawer.dragStartBehavior}
  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag behavior used for opening
  /// and closing a drawer will begin upon the detection of a drag gesture. If
  /// set to [DragStartBehavior.down] it will begin when a down event is first
  /// detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for
  ///    the different behaviors.
  ///
  /// {@endtemplate}
  final DragStartBehavior dragStartBehavior;

  /// The color to use for the scrim that obscures primary content while a drawer is open.
  ///
  /// By default, the color used is [Colors.black54]
  final Color scrimColor;

  /// Determines if the [BujuanDrawer] can be opened with a drag gesture.
  ///
  /// By default, the drag gesture is enabled.
  final bool enableOpenDragGesture;

  /// The width of the area within which a horizontal swipe will open the
  /// drawer.
  ///
  /// By default, the value used is 20.0 added to the padding edge of
  /// `MediaQuery.of(context).padding` that corresponds to [alignment].
  /// This ensures that the drag area for notched devices is not obscured. For
  /// example, if [alignment] is set to [DrawerAlignment.start] and
  /// `TextDirection.of(context)` is set to [TextDirection.ltr],
  /// 20.0 will be added to `MediaQuery.of(context).padding.left`.
  final double edgeDragWidth;

  @override
  DrawerControllerState createState() => DrawerControllerState();
}

/// State for a [DrawerController].
///
/// Typically used by a [Scaffold] to [open] and [close] the drawer.
class DrawerControllerState extends State<DrawerController> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _scrimColorTween = _buildScrimColorTween();
    _controller = AnimationController(duration: _kBaseSettleDuration, vsync: this)
      ..addListener(_animationChanged)
      ..addStatusListener(_animationStatusChanged);
  }

  @override
  void dispose() {
    _historyEntry?.remove();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DrawerController oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrimColor != oldWidget.scrimColor)
      _scrimColorTween = _buildScrimColorTween();
  }

  void _animationChanged() {
    setState(() {
      // The animation controller's state is our build state, and it changed already.
    });
  }

  LocalHistoryEntry _historyEntry;
  final FocusScopeNode _focusScopeNode = FocusScopeNode();

  void _ensureHistoryEntry() {
    if (_historyEntry == null) {
      final ModalRoute<dynamic> route = ModalRoute.of(context);
      if (route != null) {
        _historyEntry = LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
        route.addLocalHistoryEntry(_historyEntry);
        FocusScope.of(context).setFirstFocus(_focusScopeNode);
      }
    }
  }

  void _animationStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.forward:
        _ensureHistoryEntry();
        break;
      case AnimationStatus.reverse:
        _historyEntry?.remove();
        _historyEntry = null;
        break;
      case AnimationStatus.dismissed:
        break;
      case AnimationStatus.completed:
        break;
    }
  }

  void _handleHistoryEntryRemoved() {
    _historyEntry = null;
    close();
  }

  AnimationController _controller;

  void _handleDragDown(DragDownDetails details) {
    _controller.stop();
    _ensureHistoryEntry();
  }

  void _handleDragCancel() {
    if (_controller.isDismissed || _controller.isAnimating)
      return;
    if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  final GlobalKey _drawerKey = GlobalKey();

  double get _width {
    final RenderBox box = _drawerKey.currentContext?.findRenderObject() as RenderBox;
    if (box != null)
      return box.size.width;
    return _kWidth; // drawer not being shown currently
  }

  bool _previouslyOpened = false;

  void _move(DragUpdateDetails details) {
    double delta = details.primaryDelta / _width;
    switch (widget.alignment) {
      case DrawerAlignment.start:
        break;
      case DrawerAlignment.end:
        delta = -delta;
        break;
    }
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        _controller.value -= delta;
        break;
      case TextDirection.ltr:
        _controller.value += delta;
        break;
    }

    final bool opened = _controller.value > 0.5;
    if (opened != _previouslyOpened && widget.drawerCallback != null)
      widget.drawerCallback(opened);
    _previouslyOpened = opened;
  }

  void _settle(DragEndDetails details) {
    if (_controller.isDismissed)
      return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / _width;
      switch (widget.alignment) {
        case DrawerAlignment.start:
          break;
        case DrawerAlignment.end:
          visualVelocity = -visualVelocity;
          break;
      }
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _controller.fling(velocity: -visualVelocity);
          if (widget.drawerCallback != null)
            widget.drawerCallback(visualVelocity < 0.0);
          break;
        case TextDirection.ltr:
          _controller.fling(velocity: visualVelocity);
          if (widget.drawerCallback != null)
            widget.drawerCallback(visualVelocity > 0.0);
          break;
      }
    } else if (_controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  /// Starts an animation to open the drawer.
  ///
  /// Typically called by [ScaffoldState.openDrawer].
  void open() {
    _controller.fling(velocity: 1.0);
    if (widget.drawerCallback != null)
      widget.drawerCallback(true);
  }

  /// Starts an animation to close the drawer.
  void close() {
    _controller.fling(velocity: -1.0);
    if (widget.drawerCallback != null)
      widget.drawerCallback(false);
  }

  ColorTween _scrimColorTween;
  final GlobalKey _gestureDetectorKey = GlobalKey();

  ColorTween _buildScrimColorTween() {
    return ColorTween(begin: Colors.transparent, end: widget.scrimColor ?? Colors.black54);
  }

  AlignmentDirectional get _drawerOuterAlignment {
    assert(widget.alignment != null);
    switch (widget.alignment) {
      case DrawerAlignment.start:
        return AlignmentDirectional.centerStart;
      case DrawerAlignment.end:
        return AlignmentDirectional.centerEnd;
    }
    return null;
  }

  AlignmentDirectional get _drawerInnerAlignment {
    assert(widget.alignment != null);
    switch (widget.alignment) {
      case DrawerAlignment.start:
        return AlignmentDirectional.centerEnd;
      case DrawerAlignment.end:
        return AlignmentDirectional.centerStart;
    }
    return null;
  }

  Widget _buildDrawer(BuildContext context) {
    final bool drawerIsStart = widget.alignment == DrawerAlignment.start;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final TextDirection textDirection = Directionality.of(context);

    double dragAreaWidth = widget.edgeDragWidth;
    if (widget.edgeDragWidth == null) {
      switch (textDirection) {
        case TextDirection.ltr:
          dragAreaWidth = _kEdgeDragWidth +
            (drawerIsStart ? padding.left : padding.right);
          break;
        case TextDirection.rtl:
          dragAreaWidth = _kEdgeDragWidth +
            (drawerIsStart ? padding.right : padding.left);
          break;
      }
    }

    if (_controller.status == AnimationStatus.dismissed) {
      if (widget.enableOpenDragGesture) {
        return Align(
          alignment: _drawerOuterAlignment,
          child: GestureDetector(
            key: _gestureDetectorKey,
            onHorizontalDragUpdate: _move,
            onHorizontalDragEnd: _settle,
            behavior: HitTestBehavior.translucent,
            excludeFromSemantics: true,
            dragStartBehavior: widget.dragStartBehavior,
            child: Container(width: dragAreaWidth),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    } else {
      bool platformHasBackButton;
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
          platformHasBackButton = true;
          break;
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          platformHasBackButton = false;
          break;
      }
      assert(platformHasBackButton != null);
      return GestureDetector(
        key: _gestureDetectorKey,
        onHorizontalDragDown: _handleDragDown,
        onHorizontalDragUpdate: _move,
        onHorizontalDragEnd: _settle,
        onHorizontalDragCancel: _handleDragCancel,
        excludeFromSemantics: true,
        dragStartBehavior: widget.dragStartBehavior,
        child: RepaintBoundary(
          child: Stack(
            children: <Widget>[
              BlockSemantics(
                child: ExcludeSemantics(
                  // On Android, the back button is used to dismiss a modal.
                  excluding: platformHasBackButton,
                  child: GestureDetector(
                    onTap: close,
                    child: Semantics(
                      label: MaterialLocalizations.of(context)?.modalBarrierDismissLabel,
                      child: MouseRegion(
                        opaque: true,
                        child: Container( // The drawer's "scrim"
                          color: _scrimColorTween.evaluate(_controller),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: _drawerOuterAlignment,
                child: Align(
                  alignment: _drawerInnerAlignment,
                  widthFactor: _controller.value,
                  child: RepaintBoundary(
                    child: FocusScope(
                      key: _drawerKey,
                      node: _focusScopeNode,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return ListTileTheme(
      style: ListTileStyle.drawer,
      child: _buildDrawer(context),
    );
  }
}
