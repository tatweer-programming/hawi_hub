import 'package:flutter/material.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/modules/auth/view/screens/login_screen.dart';
import 'package:hawihub/src/modules/main/view/screens/main_screen.dart';
import 'package:hawihub/src/modules/main/view/screens/questions_screen.dart';
import 'package:hawihub/src/modules/main/view/screens/terms_conditions_screen.dart';
import 'package:hawihub/src/modules/places/view/screens/add_booking_screen.dart';
import 'package:hawihub/src/modules/places/view/screens/place_location_screen.dart';
import 'package:hawihub/src/modules/places/view/screens/place_screen.dart';
import '../../modules/games/data/models/player.dart';
import '../../modules/games/view/widgets/screens/all_players_screen.dart';
import '../../modules/games/view/widgets/screens/create_game_screen.dart';
import '../../modules/games/view/widgets/screens/game_screen.dart';
import '../../modules/main/view/screens/notifications_screen.dart';
import '../../modules/main/view/screens/splash_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    print(settings.toString());
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) =>
          const SplashScreen(
            nextScreen: MainScreen(),
            // nextScreen: ConstantsManager.userToken == null
            //     ? const GetStartedScreen()
            //     : const MainScreen(),
          ),
        );
      case Routes.place:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => PlaceScreen(placeId: arguments['id']));
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const MainScreen());
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => PlaceScreen(placeId: arguments['id']));
      case Routes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case Routes.game:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => GameDetailsScreen(id: arguments['id']));

      case Routes.allPlayers:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                AllPlayersScreen(
                    players: arguments['players'] as List<GamePlayer>));
      case Routes.createGame:
        return MaterialPageRoute(builder: (_) => const CreateGameScreen());
      case Routes.placeLocation:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                PlaceLocationScreen(location: arguments['location']));
      case Routes.questions:
        return MaterialPageRoute(builder: (_) => const QuestionsScreen());
      case Routes.termsAndCondition:
        return MaterialPageRoute(builder: (_) => const TermsConditionsScreen());
      case Routes.bookNow:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => AddBookingScreen(placeId: arguments['id']));

      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.phonelink_erase_rounded),
                          Text('No route defined for ${settings.name}'),
                        ],
                      ),
                    )));
    }
  }
}
