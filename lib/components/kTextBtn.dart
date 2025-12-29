import 'package:flutter/material.dart';

class MyTextBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback? pressMe;
  const MyTextBtn({super.key, required this.child, this.pressMe});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: pressMe,
      child: child,
    );
  }
}
