import 'package:flutter/material.dart';
class MyField extends StatelessWidget {
  final InputDecoration? myDecoration;
  final TextInputType? type;
  final TextEditingController? myController;
  const MyField({super.key, this.myDecoration, this.type, this.myController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: myDecoration,
      keyboardType: type,
      controller: myController,
    );
  }
}
