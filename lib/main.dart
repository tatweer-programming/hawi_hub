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
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'firebase_options.dart';
import 'generated/l10n.dart';

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
  print(ConstantsManager.userId);
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
              create: (BuildContext context) => AuthBloc(AuthInitial())),
          BlocProvider<ChatBloc>(
              create: (BuildContext context) => ChatBloc(ChatInitial())),
          BlocProvider<GamesBloc>(
              create: (BuildContext context) => GamesBloc.get()),
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
