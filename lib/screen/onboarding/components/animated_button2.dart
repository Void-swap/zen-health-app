import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
//import 'package:cupertino_icons/cupertino_icons.dart';

class AnimatedBtn2 extends StatelessWidget {
  const AnimatedBtn2({
    super.key,
    required RiveAnimationController btnAnimationController2,
    required this.press,
  }) : _btnAnimationController2 = btnAnimationController2;

  final VoidCallback press;
  final RiveAnimationController _btnAnimationController2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //detects tap guesture and shows animation
      onTap: press,
      child: SizedBox(
        height: 64,
        width: 260,
        child: Stack(
          children: [
            RiveAnimation.asset(
              'assets/RiveAssets/button.riv',
              controllers: [_btnAnimationController2],
            ),
            const Positioned.fill(
              top: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.arrow_right),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Register as Helper ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
