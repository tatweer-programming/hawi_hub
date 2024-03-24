import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hawihub/src/modules/main/view/widgets/pages/home_page.dart';
import 'package:hawihub/src/modules/main/view/widgets/pages/more_page.dart';
import 'package:hawihub/src/modules/places/view/widgets/pages/book_page.dart';

import '../../games/view/widgets/pages/play_page.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  static MainCubit cubit = MainCubit();

  static MainCubit get() => cubit;

  MainCubit() : super(MainInitial());
  List<Widget> pages = [
    const HomePage(),
    const PlayPage(),
    const BookPage(),
    const MorePage(),
  ];
  int currentIndex = 0;

  void changePage(int index) {
    currentIndex = index;
    emit(ChangePage(index));
  }
}
