
import 'package:bujuan/constant/Screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget{
  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;

  NavBar({
    Key key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 26,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    @required this.items,
    @required this.onItemSelected,
  }) {
    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
    assert(onItemSelected != null);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: Container(
        width: double.infinity,
        height: Screens.setHeight(46),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: items.map((item) {
            var index = items.indexOf(item);
            return GestureDetector(
              onTap: () => onItemSelected(index),
              child: _ItemWidget(
                item: item,
                iconSize: iconSize,
                isSelected: index == selectedIndex,
                backgroundColor: Colors.transparent,
                itemCornerRadius: itemCornerRadius,
                animationDuration: animationDuration,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight( Screens.setHeight(46));
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;

  const _ItemWidget(
      {Key key,
        @required this.item,
        @required this.isSelected,
        @required this.backgroundColor,
        @required this.animationDuration,
        @required this.itemCornerRadius,
        @required this.iconSize})
      : assert(isSelected != null),
        assert(item != null),
        assert(backgroundColor != null),
        assert(animationDuration != null),
        assert(itemCornerRadius != null),
        assert(iconSize != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: Alignment.center,
      width: isSelected ? Screens.setWidth(38) : Screens.setWidth(50),
      height: Screens.setWidth(38),
      duration: animationDuration,
      decoration: BoxDecoration(
        color: isSelected ? item.activeColor.withOpacity(0.5) : backgroundColor,
        borderRadius: BorderRadius.circular(itemCornerRadius),
        border: isSelected ? Border.all(color: Colors.grey.withOpacity(.1),width: 1):null,
      ),
      child: ListView(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0),
                child: IconTheme(
                  data: IconThemeData(
                      size:  Screens.setSp(20),
                      color: isSelected
                          ? item.activeColor.withOpacity(1)
                          : item.inactiveColor == null ? item.activeColor : item.inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                style: TextStyle(
                  color: item.activeColor,
                  fontWeight: FontWeight.bold,
                ),
                child: Container(),
              ) : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}

class BottomNavyBarItem {
  final Icon icon;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;

  BottomNavyBarItem({
    @required this.icon,
    @required this.title,
    this.activeColor = Colors.blue,
    this.inactiveColor,
  }) {
    assert(icon != null);
    assert(title != null);
  }
}
