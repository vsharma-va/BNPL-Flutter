import 'package:flutter/material.dart';

class CarAnim extends StatelessWidget {
  CarAnim({
    required this.animController,
    required this.width,
  })  : animationDrive = Tween(begin: -width / 2, end: width + 2000).animate(
          CurvedAnimation(
            parent: animController,
            curve: const Interval(0.0, 1.0, curve: Curves.easeInQuint),
          ),
        ),
        animationColor = ColorTween(
          begin: Color.fromRGBO(239, 95, 85, 1),
          end: Colors.black,
        ).animate(
          CurvedAnimation(
            parent: animController,
            curve: const Interval(0.0, 0.9, curve: Curves.easeInQuint),
          ),
        );

  final AnimationController animController;
  final Animation<double> animationDrive;
  final Animation<Color?> animationColor;

  final double width;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Positioned(
      child: Image.asset(
        "./assets/Images/car(1).png",
        color: animationColor.value,
        scale: 10,
      ),
      right: animationDrive.value,
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
