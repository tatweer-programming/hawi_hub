import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hawihub/src/core/apis/dio_helper.dart';
import 'package:hawihub/src/core/local/shared_prefrences.dart';
import 'package:hawihub/src/core/routing/app_router.dart';
import 'package:hawihub/src/core/routing/routes.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/core/utils/localization_manager.dart';
import 'package:hawihub/src/core/utils/theme_manager.dart';
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:sizer/sizer.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  ConstantsManager.userId = await CacheHelper.getData(key: 'id');
  ConstantsManager.userToken = await CacheHelper.getData(key: 'token');
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
            create: (BuildContext context) => AuthBloc(AuthInitial()),
          ),
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
