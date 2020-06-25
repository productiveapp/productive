import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:productive/common/resources/strings.dart';
import 'package:productive/utils/animation/animated_scale.dart';
import 'package:productive/utils/animation/animated_scale_button.dart';
import 'package:productive/utils/extensions/gradient_extensions.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  NavButtonsState navState =
      const NavButtonsState(selectedIndex: 0, pressedIndex: -1);

  void _selectPage(int index) {
    setState(() {
      navState = navState.copyWith(selectedIndex: index);
    });
  }

  void _touchIcon(int index) {
    setState(() {
      navState = navState.copyWith(pressedIndex: index);
    });
  }

  void _selectHome() => _selectPage(0);

  void _selectStats() => _selectPage(1);

  void _touchHomeIcon() => _touchIcon(0);

  void _touchStatsIcon() => _touchIcon(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
            color: Color(0x33CCCCCC),
            offset: Offset(-4, -4),
            blurRadius: 8,
            spreadRadius: 8)
      ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        child: BottomAppBar(
          elevation: 20,
          shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(),
            StadiumBorder(
              side: BorderSide(),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _selectHome,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AnimatedScale(
                      duration: _getDuration(0, navState),
                      scale: _getScale(0, navState),
                      child: SvgPicture.asset(
                        R.svgImages.homeIcon,
                        height: 32,
                      ).getShadedWidget(_getGradient(0, navState)),
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _selectStats,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AnimatedScale(
                      duration: _getDuration(1, navState),
                      scale: _getScale(1, navState),
                      child: SvgPicture.asset(
                        R.svgImages.statsIcon,
                        height: 32,
                      ).getShadedWidget(_getGradient(1, navState)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient _getGradient(int buttonIndex, NavButtonsState navState) {
    return buttonIndex == navState.selectedIndex
        ? blueLinearGradient
        : greyLinearGradient;
  }

  Duration _getDuration(int buttonIndex, NavButtonsState navState) {
    final bool toEnlarge = buttonIndex == navState.selectedIndex ||
        buttonIndex != navState.pressedIndex;
    return Duration(milliseconds: toEnlarge ? 200 : 50);
  }

  double _getScale(int buttonIndex, NavButtonsState navState) {
    if (buttonIndex == navState.pressedIndex &&
        buttonIndex == navState.selectedIndex) return 0.8;
    if (buttonIndex == navState.pressedIndex) return 0.6;
    if (buttonIndex != navState.pressedIndex &&
        buttonIndex != navState.selectedIndex) return 0.8;
    return 1.0;
  }
}

class NavButtonsState {
  const NavButtonsState({this.selectedIndex, this.pressedIndex});

  final int selectedIndex;
  final int pressedIndex;

  NavButtonsState copyWith({
    int selectedIndex,
    int pressedIndex,
  }) {
    if ((selectedIndex == null ||
            identical(selectedIndex, this.selectedIndex)) &&
        (pressedIndex == null || identical(pressedIndex, this.pressedIndex))) {
      return this;
    }

    return NavButtonsState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      pressedIndex: pressedIndex ?? this.pressedIndex,
    );
  }
}
