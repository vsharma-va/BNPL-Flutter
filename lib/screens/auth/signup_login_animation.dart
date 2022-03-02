import 'package:flutter/material.dart';

class SignUpLoginAnim extends StatelessWidget {
  SignUpLoginAnim({
    Key? key,
    required this.animController,
    required this.top,
    required this.height,
    required this.width,
    required this.cardChild,
    required this.globalKey,
  }) : animationMove = Tween(begin: 0.0, end: width + 500).animate(
          CurvedAnimation(
            parent: animController,
            curve: const Interval(0.0, 1.0, curve: Curves.easeOutQuint),
          ),
        );

  final AnimationController animController;
  final Animation<double> animationMove;

  final double top;
  final double height;
  final double width;

  final Widget cardChild;
  final GlobalKey globalKey;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Positioned(
      key: globalKey,
      // top: (height / 2) - (height * 0.5) / 2,
      top: top,
      left: animationMove.value == width + 500 ? 0 : animationMove.value,
      child: Container(
        height: height,
        // height: height * 0.5,
        padding: const EdgeInsets.all(20),
        // width: width - 40,
        width: width,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/Images/login_signup_background.jpg"),
            fit: BoxFit.cover,
          ),
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              spreadRadius: 5,
            ),
          ],
        ),

        child: cardChild,
      ),
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
