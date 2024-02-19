import 'package:flutter/material.dart';

class AminatedBar extends StatelessWidget {
  const AminatedBar({
    super.key,
    required this.isActive,
  });
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      //this thing adds animation to it
      duration: const Duration(milliseconds: 250),
      // the BLUE SMALL BAR in BOTTOM NAV  that TRACKS TAPS
      height: 4,
      width: isActive ? 20 : 0,
      margin: const EdgeInsets.only(bottom: 2),
      decoration: const BoxDecoration(
        color: Color(0xFF8C9EFF),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
