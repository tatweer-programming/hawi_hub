import 'package:flutter/material.dart';

extension NavigationMethods on BuildContext {
  void pop() {
    Navigator.pop(this);
  }

  void push(
    String route, {
    Object? arguments,
  }) {
    Navigator.pushNamed(this, route, arguments: arguments);
  }

  void pushAndRemove(String route) {
    Navigator.pushNamedAndRemoveUntil(this, route, (route) => false);
  }

  void pushReplacement(String route) {
    Navigator.pushReplacementNamed(
      this,
      route,
    );
  }
}
