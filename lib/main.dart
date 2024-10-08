import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hawihub/src/core/apis/dio_helper.dart';
import 'package:hawihub/src/core/local/shared_prefrences.dart';
import 'package:hawihub/src/core/routing/app_router.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/services/dep_injection.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/core/utils/localization_manager.dart';
import 'package:hawihub/src/core/utils/theme_manager.dart';
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/chat/bloc/chat_bloc.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/data/services/notification_services.dart';
import 'package:hawihub/src/modules/payment/bloc/payment_cubit.dart';
import 'package:hawihub/src/modules/places/bloc/place_bloc.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'src/modules/places/data/models/place_location.dart';

Future<void> main() async {
  timeago.setLocaleMessages("ar", timeago.ArMessages());
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationServices.init();
  ServiceLocator.init();
  ConstantsManager.userId = await CacheHelper.getData(key: 'userId');
  // print(ConstantsManager.userId);
  await LocalizationManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<MainCubit>(create: (context) => MainCubit.get()),
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(),
          ),
          BlocProvider<ChatBloc>(
            create: (BuildContext context) => ChatBloc(
            ),
          ),
          BlocProvider<GamesBloc>(
            create: (BuildContext context) => GamesBloc.get(),
          ),
          BlocProvider<PlaceBloc>(
              create: (BuildContext context) => PlaceBloc.get()),
          BlocProvider<PaymentCubit>(
              create: (BuildContext context) => PaymentCubit.get()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          AppRouter appRouter = AppRouter();
          return BlocBuilder<MainCubit, MainState>(
            bloc: MainCubit.get(),
            builder: (context, state) {
              return MaterialApp(
                title: LocalizationManager.getAppTitle(),
                initialRoute: Routes.splash,
                onGenerateRoute: appRouter.onGenerateRoute,
                locale: LocalizationManager.getCurrentLocale(),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                theme: getAppTheme(),
              );
            },
          );
        }));
  }
}
/* TODO: what abdallah need to handle:
    - handle wallet
    - handle notification in background,
    - add birthday to player,
*/

/// update place rating after editing
List<Place> dummyPlaces = [
  Place(
    id: 1,
    name: "ملعب القاهرة الدولي",
    address: "شارع 26 يوليو، قصر النيل، القاهرة",
    workingHours: [],
    //location: PlaceLocation(longitude: 31.2357, latitude: 30.0483),
    location: PlaceLocation(longitude: 31.2357, latitude: 30.0483),
    description: "ملعب متعدد الاستخدامات، يستضيف المباريات الدولية والمحلية.",
    sport: 1,
    price: 500.0,
    ownerId: 1,
    images: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBpdHgzRawHvkOWHFNOUfvKaR1tf6rvQ_TLA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBpdHgzRawHvkOWHFNOUfvKaR1tf6rvQ_TLA&s"
    ],
    totalGames: 100,
    totalRatings: 250,
    rating: 4.5,
    feedbacks: [],
    ownerName: "إتحاد الكرة المصري",
    ownerImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBpdHgzRawHvkOWHFNOUfvKaR1tf6rvQ_TLA&s",
    citId: 1,
    approvalStatus: 1,
    availableGender: Gender.both,
    deposit: 100,
    isShared: false,
  ),
  Place(
    id: 2,
    name: "استاد برج العرب",
    address: "الكيلو 21، طريق مصر إسكندرية الصحراوي",
    workingHours: [],
    //location: PlaceLocation(longitude: "29.8834", latitude: "31.1862"),
    location: PlaceLocation(longitude: 31.2357, latitude: 30.0483),
    description:
        "أحد أكبر الملاعب في مصر، ويستضيف العديد من الفعاليات الرياضية.",
    sport: 1,
    price: 600.0,
    ownerId: 2,
    images: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBpdHgzRawHvkOWHFNOUfvKaR1tf6rvQ_TLA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBpdHgzRawHvkOWHFNOUfvKaR1tf6rvQ_TLA&s"
    ],
    totalGames: 80,
    totalRatings: 150,
    rating: 4.7,
    feedbacks: [],
    ownerName: "إتحاد الكرة المصري",
    ownerImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBpdHgzRawHvkOWHFNOUfvKaR1tf6rvQ_TLA&s",
    citId: 2,
    approvalStatus: 1,
    availableGender: Gender.both,
    deposit: 150,
    isShared: true,
  ),
  Place(
    id: 3,
    name: "استاد القاهرة",
    address: "شارع 26 يوليو، قصر النيل، القاهرة",
    workingHours: [],
    //location: PlaceLocation(longitude: "31.2357", latitude: "30.0483"),
    location: PlaceLocation(longitude: 31.2357, latitude: 30.0483),
    description: "يستضيف المباريات النهائية للكثير من البطولات.",
    sport: 1,
    price: 700.0,
    ownerId: 3,
    images: [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBpdHgzRawHvkOWHFNOUfvKaR1tf6rvQ_TLA&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBpdHgzRawHvkOWHFNOUfvKaR1tf6rvQ_TLA&s"
    ],
    totalGames: 90,
    totalRatings: 300,
    rating: 4.8,
    feedbacks: [],
    ownerName: "إتحاد الكرة المصري",
    ownerImage:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBpdHgzRawHvkOWHFNOUfvKaR1tf6rvQ_TLA&s",
    citId: 1,
    approvalStatus: 1,
    availableGender: Gender.both,
    deposit: 200,
    isShared: false,
  ),
];
