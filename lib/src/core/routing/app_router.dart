import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/modules/main/view/screens/main_screen.dart';

import '../../modules/main/view/screens/splash_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
            builder: (_) => const SplashScreen(
                  nextScreen: MainScreen(),
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                    body: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.phonelink_erase_rounded),
                      Text('No route defined for ${settings.name}'),
                    ],
                  ),
                )));
    }
  }
}
