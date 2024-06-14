import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geolocation_service/flutter_geolocation_service.dart';
import 'package:hawihub/src/core/error/remote_error.dart';
import 'package:hawihub/src/core/local/shared_prefrences.dart';
import 'package:hawihub/src/core/services/location_services.dart';
import 'package:hawihub/src/core/utils/localization_manager.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/main/data/models/app_notification.dart';
import 'package:hawihub/src/modules/main/data/models/sport.dart';
import 'package:hawihub/src/modules/main/data/services/main_services.dart';
import 'package:hawihub/src/modules/main/data/services/notification_services.dart';
import 'package:hawihub/src/modules/main/view/widgets/pages/home_page.dart';
import 'package:hawihub/src/modules/main/view/widgets/pages/more_page.dart';
import 'package:hawihub/src/modules/places/bloc/place__bloc.dart';
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
  List<Sport> sportsList = [];
  int? currentCityId;
  List<AppNotification> notifications = [];
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
      emit(GetBannersError(l));
    }, (r) {
      bannerList = r;
      emit(GetBannersSuccess(r));
    });
  }

  Future<void> getSports() async {
    emit(GetSportsLoading());
    var result = await mainServices.getSports();
    result.fold((l) {
      emit(GetSportsError(l));
    }, (r) {
      sportsList = r;
      emit(GetSportsSuccess(r));
    });
  }

  Future<void> selectCity(String city) async {
    int cityId = LocalizationManager.getSaudiCities.indexOf(city) + 1;
    currentCityId = cityId;
    await saveCurrentCity(cityId);
    PlaceBloc placeBloc = PlaceBloc.get();
    emit(SelectCityState(cityId));
    placeBloc.add(GetAllPlacesEvent(cityId));
  }

  void selectSport(String sport) {
    PlaceBloc placeBloc = PlaceBloc.get();
    // placeBloc.add( );
  }

  Future<void> getCurrentCity() async {
    currentCityId = await CacheHelper.getData(key: "cityId") ?? 1;
    print(" city id $currentCityId");
    emit(GetCitySuccessState(currentCityId!));
  }

  Future<void> saveCurrentCity(int cityId) async {
    await CacheHelper.saveData(key: "cityId", value: cityId).then((value) {
      print("city saved");
    });
  }

  Future<void> showDialog() async {
    emit(ShowDialogState());
  }

  Future<void> changeLanguage(int index) async {
    await LocalizationManager.setLocale(index);
    emit(ChangeLocaleState(index));
  }

  Future initializeHomePage() async {
    PlaceBloc placeBloc = PlaceBloc.get();
    GamesBloc gamesBloc = GamesBloc.get();

    await getCurrentCity().then((value) async{
      gamesBloc.add(GetGamesEvent(currentCityId!));
      placeBloc.add(GetAllPlacesEvent(currentCityId!));
    });
    await getBanner();
    await getSports();
  }
  getNotifications() async {
    emit(GetNotificationsLoading());
    NotificationServices notificationServices = NotificationServices();
    var result = await notificationServices.getNotifications();
    result.fold((l) {
      emit(GetNotificationsError(l));
    }, (r) {
      notifications = r;
      emit(GetNotificationsSuccess(r));
    });
  }
  void markNotificationAsRead(int i) {
    NotificationServices().markAsRead(i);
  }
}
