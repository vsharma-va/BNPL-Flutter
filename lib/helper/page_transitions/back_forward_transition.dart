import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class ForwardOrBackwardTransition extends PageRouteBuilder {
  final Widget child;
  final bool back;
  ForwardOrBackwardTransition({
    required this.child,
    this.back = false, // if not back then it is assumed to be forward
  }) : super(
          transitionDuration: Duration(milliseconds: 250),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: back ? const Offset(1, 0) : const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}
