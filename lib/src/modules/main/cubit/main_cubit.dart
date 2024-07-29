import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/local/shared_prefrences.dart';
import 'package:hawihub/src/core/utils/localization_manager.dart';
import 'package:hawihub/src/modules/games/bloc/games_bloc.dart';
import 'package:hawihub/src/modules/main/data/models/app_notification.dart';
import 'package:hawihub/src/modules/main/data/models/sport.dart';
import 'package:hawihub/src/modules/main/data/services/main_services.dart';
import 'package:hawihub/src/modules/main/data/services/notification_services.dart';
import 'package:hawihub/src/modules/places/bloc/place_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  static MainCubit cubit = MainCubit();

  static MainCubit get() => cubit;
  MainServices mainServices = MainServices();

  MainCubit() : super(MainInitial());

  int currentIndex = 0;

  void changePage(int index) {
    if (currentIndex != index) {
      currentIndex = index;
      emit(ChangePage(index));
    }
  }

  List<String> bannerList = [];
  List<Sport> sportsList = [];
  String? selectedSport;

  int? currentCityId;
  List<AppNotification> notifications = [];

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
    GamesBloc gamesBloc = GamesBloc.get();
    emit(SelectCityState(cityId));
    placeBloc.add(
      GetAllPlacesEvent(cityId, refresh: true),
    );
    gamesBloc.add(GetGamesEvent(cityId, refresh: true));
  }

  void selectSport(String sport) {
    PlaceBloc placeBloc = PlaceBloc.get();
    GamesBloc gamesBloc = GamesBloc.get();
    if (sport == "all") {
      placeBloc.add(const SelectSport(-1));
      gamesBloc.add(const SelectSportEvent(-1));
      selectedSport = null;
    } else {
      placeBloc
          .add(SelectSport(sportsList.firstWhere((e) => e.name == sport).id));
      gamesBloc.add(SelectSportEvent(
        sportsList.firstWhere((e) => e.name == sport).id,
      ));
      selectedSport = sport;
    }

    // placeBloc.add();
  }

  Future<void> getCurrentCity() async {
    currentCityId = await CacheHelper.getData(key: "cityId") ?? 1;
    emit(GetCitySuccessState(currentCityId!));
  }

  Future<void> saveCurrentCity(int cityId) async {
    await CacheHelper.saveData(key: "cityId", value: cityId).then((value) {});
  }

  Future<void> changeLanguage(int index) async {
    emit(ChangeLocaleLoading());
    await LocalizationManager.setLocale(index);
    emit(ChangeLocaleState(index));
  }

  Future initializeHomePage({bool refresh = false}) async {
    PlaceBloc placeBloc = PlaceBloc.get();
    GamesBloc gamesBloc = GamesBloc.get();

    await getCurrentCity().then((value) async {
      gamesBloc.add(GetGamesEvent(currentCityId!, refresh: refresh));
      placeBloc.add(GetAllPlacesEvent(currentCityId!, refresh: refresh));
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
