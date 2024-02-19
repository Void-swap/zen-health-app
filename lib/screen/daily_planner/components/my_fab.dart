import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  final Function()? onPressed;

  const MyFloatingActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      mini: true,
      backgroundColor: const Color.fromARGB(255, 192, 170, 250),
      elevation: 5,
      child: const Icon(Icons.add),
    );
  }
}
