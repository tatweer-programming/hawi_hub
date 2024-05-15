import 'dart:async';

import 'package:app_links/app_links.dart';
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
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/places/bloc/place__bloc.dart';
import 'package:sizer/sizer.dart';

import 'generated/l10n.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  timeago.setLocaleMessages("ar", timeago.ArMessages());
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  ServiceLocator.init();
  ConstantsManager.userId = await CacheHelper.getData(key: 'id');
  ConstantsManager.userToken = await CacheHelper.getData(key: 'token');
  await LocalizationManager.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();

    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      print('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    _navigatorKey.currentState?.pushNamed(uri.fragment);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<MainCubit>(create: (context) => MainCubit.get()),
          BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc(AuthInitial())),
          BlocProvider<GamesBloc>(create: (BuildContext context) => GamesBloc.get()),
          BlocProvider<PlaceBloc>(create: (BuildContext context) => PlaceBloc.get()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          AppRouter appRouter = AppRouter();
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
        }));
  }
}
