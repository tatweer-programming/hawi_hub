import 'package:flutter/material.dart';
import 'package:hawihub/main.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/dummy/dummy_data.dart';
import 'package:hawihub/src/modules/auth/view/screens/confirm_email_screen.dart';
import 'package:hawihub/src/modules/auth/view/screens/login_screen.dart';
import 'package:hawihub/src/modules/auth/view/screens/profile_screen.dart';
import 'package:hawihub/src/modules/games/view/widgets/screens/select_game_time_screen.dart';
import 'package:hawihub/src/modules/main/view/screens/main_screen.dart';
import 'package:hawihub/src/modules/main/view/screens/questions_screen.dart';
import 'package:hawihub/src/modules/main/view/screens/terms_conditions_screen.dart';
import 'package:hawihub/src/modules/payment/presentation/screens/my_wallet.dart';
import 'package:hawihub/src/modules/places/view/screens/add_booking_screen.dart';
import 'package:hawihub/src/modules/main/view/screens/explore_by_sports.dart';
import 'package:hawihub/src/modules/places/view/screens/place_location_screen.dart';
import 'package:hawihub/src/modules/places/view/screens/place_reviews.dart';
import 'package:hawihub/src/modules/places/view/screens/place_screen.dart';
import 'package:hawihub/src/modules/places/view/widgets/components.dart';
import 'package:sizer/sizer.dart';

import '../../modules/auth/view/screens/get_started_screen.dart';
import '../../modules/games/data/models/player.dart';
import '../../modules/games/view/widgets/screens/all_players_screen.dart';
import '../../modules/games/view/widgets/screens/create_game_screen.dart';
import '../../modules/games/view/widgets/screens/game_screen.dart';
import '../../modules/main/view/screens/notifications_screen.dart';
import '../../modules/main/view/screens/splash_screen.dart';
import '../../modules/places/view/screens/view_image_screen.dart';
import '../utils/constance_manager.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    print(settings.toString());
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) =>
              SplashScreen(
                //    nextScreen: EmptyScreen(),
                nextScreen: ConstantsManager.userId == null
                    ? (ConstantsManager.isFirstTime == true ||
                    ConstantsManager.isFirstTime == null
                    ? const GetStartedScreen()
                    : const LoginScreen())
                    : const MainScreen(),
              ),
        );
      case Routes.place:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => PlaceScreen(placeId: arguments['id']));
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.profile:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                ProfileScreen(
                    id: arguments['id'], userType: arguments['userType']));
      case Routes.wallet:
        return MaterialPageRoute(builder: (_) => const MyWallet());
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
        Map<String, dynamic>? arguments =
        settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (_) =>
                CreateGameScreen(
                  placeId: arguments?['placeId'],
                  placeName: arguments?['placeName'],
                ));
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
      case Routes.placeFeedbacks:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                PlaceFeedbacksScreen(
                  id: arguments['id'],
                ));
      case Routes.selectGameTime:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                SelectGameTimeScreen(
                  placeId: arguments['id'],
                ));
      case Routes.confirmEmail:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => ConfirmEmailScreen(bloc: arguments['bloc']));
      case Routes.viewImages:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                FullScreenImageGallery(
                  imageUrls: arguments['imageUrls'],
                  initialIndex: arguments['index'],
                ));
      case Routes.exploreBySport:
        Map<String, dynamic> arguments =
        settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                ExploreBySportsScreen(
                  sportId: arguments['sportId'],
                ));
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

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: ListView.builder(
          itemBuilder: (context, index) =>
              PlaceItem(
                place: dummyPlaces[index],
              ),
          itemCount: dummyPlaces.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
