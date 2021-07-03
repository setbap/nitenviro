import 'package:flutter/material.dart';

class HeroLocationRoute<T> extends PageRoute {
  final Widget Function(BuildContext context, Animation animation) builder;

  HeroLocationRoute({required this.builder});
  @override
  Color? get barrierColor => Colors.white10;

  @override
  String? get barrierLabel => "heroLocation";

  @override
  bool get barrierDismissible => true;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      builder(context, animation);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return super.buildTransitions(
      context,
      animation,
      secondaryAnimation,
      FadeTransition(opacity: animation, child: child),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(seconds: 1);
}
