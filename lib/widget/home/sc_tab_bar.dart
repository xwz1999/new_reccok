
import 'package:flutter/material.dart';

typedef TabBarItemBuilder<T> = Widget Function(
    BuildContext context, int index, T item);

typedef TabBarItemClickListener = Function(int index);

class SCTabBar<T> extends StatefulWidget {
  SCTabBar({
    required this.items,
    required this.itemBuilder,
    this.direction = Axis.horizontal,
    this.height = 30,
    this.spacing = 0,
    this.padding = const EdgeInsets.all(0),
    this.indicatorHeight = 2,
    this.indicatorColor = Colors.red,
    this.indicatorLocation = IndicatorLocation.bottom,
    this.initialIndex = 0,
    this.itemClick,
    required this.controller,
  })  : assert(items.length != 0, "item个数不能为空");

  final TabBarController controller;
  final Axis direction;
  final double height;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final IndicatorLocation indicatorLocation;
  final double indicatorHeight;
  final Color indicatorColor;
  final List<T> items;
  final TabBarItemBuilder<T> itemBuilder;
  final initialIndex;
  final TabBarItemClickListener? itemClick;

  @override
  State<StatefulWidget> createState() {
    return _SCTabBarState<T>(itemBuilder);
  }
}

class _SCTabBarState<T> extends State<SCTabBar> {
  final TabBarItemBuilder<T> itemBuilder;

  _SCTabBarState(this.itemBuilder);

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.initialIndex;
    widget.controller.jumpToIndex = (int index) {
      print(index);
      setState(() {
        _selectedIndex = index;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
          border:
              Border(right: BorderSide(color: Colors.green[300]!, width: 0.1))),
      child: ListView.builder(
        itemCount: widget.items.length,
        scrollDirection: widget.direction,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              color: Color(0xFFF2F2F2),
              padding: _itemSpaceEdge(),
              child: Container(
                height: widget.height,
                child: Stack(
                  children: [
                    itemBuilder(context, index, widget.items[index]),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: _indicatorBorder(index),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              if (widget.itemClick != null) {
                widget.itemClick!(index);
              }
              setState(() {
                _selectedIndex = index;
              });
            },
          );
        },
      ),
    );
  }

  EdgeInsetsGeometry _itemSpaceEdge() {
    if (widget.direction == Axis.horizontal) {
      return EdgeInsets.only(
        left: widget.spacing / 2,
        right: widget.spacing / 2,
      );
    } else {
      return EdgeInsets.only(
        top: widget.spacing / 2,
        bottom: widget.spacing / 2,
      );
    }
  }

  Widget _indicatorBorder(index) {
    if (index != _selectedIndex) {
      return Container();
    }

    Widget border;
    switch (widget.indicatorLocation) {
      case IndicatorLocation.top:
        border = Container(
          height: widget.indicatorHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(1), topRight: Radius.circular(5)),
              color: widget.indicatorColor),
        );
        break;
      case IndicatorLocation.left:
        border = Container(
          width: widget.indicatorHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(widget.indicatorHeight / 2),
                  topRight: Radius.circular(widget.indicatorHeight / 2)),
              color: widget.indicatorColor,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFFD5101A),
                Color(0xFFFFFFFF),
              ],
            ),

          ),
        );
        break;
      case IndicatorLocation.right:
        border = Container(
          width: widget.indicatorHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(widget.indicatorHeight / 2),
                  bottomRight: Radius.circular(widget.indicatorHeight / 2)),
              color: widget.indicatorColor),
        );
        break;
      default:
        border = Container(
          height: widget.indicatorHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5)),
              color: widget.indicatorColor),
        );
    }
    return border;
  }
}

enum IndicatorLocation { top, bottom, left, right }

class TabBarController {
  late Function(int index) jumpToIndex;
}
