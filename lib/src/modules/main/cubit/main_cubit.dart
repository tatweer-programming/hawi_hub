import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geolocation_service/flutter_geolocation_service.dart';
import 'package:hawihub/src/core/error/remote_error.dart';
import 'package:hawihub/src/core/services/location_services.dart';
import 'package:hawihub/src/modules/main/data/services/main_services.dart';
import 'package:hawihub/src/modules/main/view/widgets/pages/home_page.dart';
import 'package:hawihub/src/modules/main/view/widgets/pages/more_page.dart';
import 'package:hawihub/src/modules/places/view/widgets/pages/book_page.dart';

import '../../games/view/widgets/pages/play_page.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  static MainCubit cubit = MainCubit();

  static MainCubit get() => cubit;
  MainServices mainServices = MainServices();
  MainCubit() : super(MainInitial());
  List<Widget> pages = [
    const HomePage(),
    const PlayPage(),
    const BookPage(),
    const MorePage(),
  ];
  int currentIndex = 0;
  List<String> bannerList = [];
  void changePage(int index) {
    currentIndex = index;
    emit(ChangePage(index));
  }

  Future<void> init() async {
    await LocationServices.determinePosition().then((value) {
      print(value.toJson());
      FlutterGeolocationService service = FlutterGeolocationService();
    });
  }

  Future<void> getBanner() async {
    emit(GetBannersLoading());
    var result = await mainServices.getBanners();
    result.fold((l) {
      ExceptionManager(l).translatedMessage();
      emit(GetBannersError());
    }, (r) {
      bannerList = r;
      emit(GetBannersSuccess(r));
    });
  }
}
