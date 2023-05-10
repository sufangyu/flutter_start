import 'package:flutter/material.dart';

class CustomDialogRoute<T> extends PopupRoute<T> {
  CustomDialogRoute({
    required this.builder,
    super.settings,
  });

  final Widget Function(BuildContext context) builder;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Color? get barrierColor => Colors.black.withOpacity(0);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'CustomDialogBase';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);
}
