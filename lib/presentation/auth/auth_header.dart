import 'package:flutter/material.dart';

class AuthHeader {
  static Widget builder(context, constraints, shrinkOffset) {
    return const Center(
      child: Text(
        "Flutter Auth Example",
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
