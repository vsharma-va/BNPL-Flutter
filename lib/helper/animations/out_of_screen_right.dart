import 'package:flutter/material.dart';

class RightOutAnim extends StatelessWidget {
  RightOutAnim({
    required this.animController,
    required this.width,
    required this.child1,
  }) : animationOutOfScreen = Tween(begin: 0.0, end: width).animate(
          CurvedAnimation(
            parent: animController,
            curve: const Interval(0.0, 1.0, curve: Curves.bounceOut),
          ),
        );

  final AnimationController animController;
  final Animation<double> animationOutOfScreen;
  final double width;
  final Widget child1;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      child: child1,
      transform:
          Matrix4.translationValues(animationOutOfScreen.value, 0.0, 0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: animController,
    );
  }
}
