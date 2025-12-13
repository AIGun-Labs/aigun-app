import 'package:flutter/material.dart';

class TokenActionRoute extends PopupRoute<void> {
  final Widget child;
  final Duration _duration;

  TokenActionRoute({
    required this.child,
    Duration duration = const Duration(milliseconds: 150),
  }) : _duration = duration;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => _duration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
