import 'package:flutter/material.dart';
import 'package:productive/common/resources/r.dart';
import 'package:productive/features/splash/splash_screen.dart';
import 'package:productive/utils/extensions/gradient_extensions.dart';
import 'package:productive/utils/extensions/navigation_extension.dart';

class Fab extends StatelessWidget {
  const Fab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: () {
        context.navigateTo(const SplashScreen());
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Text(
          R.string.addTodo,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ).withBlueGradientBg(),
    );
  }
}
