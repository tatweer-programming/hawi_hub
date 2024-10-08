import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/user_access_proxy/data_source_proxy.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/bottom_nav_bar.dart';

import '../../../games/view/widgets/pages/play_page.dart';
import '../../../places/view/widgets/pages/book_page.dart';
import '../widgets/pages/home_page.dart';
import '../widgets/pages/more_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get();
    UserAccessProxy(context.read<AuthBloc>(),
            GetProfileEvent(ConstantsManager.userId!, "Player"))
        .execute([AccessCheckType.login]);
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: BlocBuilder<MainCubit, MainState>(
        bloc: mainCubit,
        buildWhen: (previous, current) => current is ChangePage,
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              mainCubit.initializeHomePage(refresh: true);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  pages[mainCubit.currentIndex],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static List<Widget> pages = const [
    HomePage(),
    BookPage(),
    PlayPage(),
    SizedBox(),
    MorePage(),
  ];
}
