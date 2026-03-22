import 'package:flutter/material.dart';

class MyDecoration {
  static InputDecoration build({String? label}) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    );
  }
}