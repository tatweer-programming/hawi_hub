import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/main/cubit/main_cubit.dart';
import 'package:hawihub/src/modules/main/view/widgets/bottom_nav_bar.dart';
import 'package:hawihub/src/modules/places/data/models/place.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit mainCubit = MainCubit.get();
    AuthBloc.get(context).add(GetProfileEvent(ConstantsManager.userId!));

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: BlocBuilder<MainCubit, MainState>(
        bloc: mainCubit,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                mainCubit.pages[mainCubit.currentIndex],
                // Center(
                //   child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: PlaceItem(
                //         place: place,
                //       )),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
