import 'package:flutter/material.dart';

extension NavigationMethods on BuildContext {
  void pop() {
    Navigator.pop(this);
  }

  void push(String route) {
    Navigator.pushNamed(this, route);
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
