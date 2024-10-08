import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hawihub/src/core/apis/dio_helper.dart';
import 'package:hawihub/src/core/apis/end_points.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/main/data/models/app_notification.dart';
import 'package:hawihub/src/modules/main/data/services/notification_services.dart';
import 'package:hawihub/src/modules/places/data/models/booking.dart';
import 'package:hawihub/src/modules/places/data/models/place_booking.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';

import '../models/place.dart';

class PlacesRemoteDataSource {
  Future<Either<Exception, List<Place>>> getAllPlaces(
      {required int cityId}) async {
    try {
      var response = await DioHelper.getData(
        path: "${EndPoints.getPlaces}$cityId",
        query: {"cityId": cityId},
      );
      List<Place> places =
          (response.data as List).map((e) => Place.fromJson(e)).toList();
      return Right(places);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Place>> getPlace({required int id}) async {
    try {
      var response = await DioHelper.getData(path: "${EndPoints.getPlace}$id");
      return Right(Place.fromJson(response.data));
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, List<PlaceBooking>>> getPlaceBookings(
      {required int placeId}) async {
    try {
      var response = await DioHelper.getData(
          path: "${EndPoints.getPlaceBookings}$placeId");
      List<PlaceBooking> bookings =
          (response.data as List).map((e) => PlaceBooking.fromJson(e)).toList();
      return Right(bookings);
    } on DioException catch (e) {
      DioException dioException = e;
      return Left(dioException);
    } on Exception catch (e) {
      return Left(e);
    }
  }
 Future <Either<Exception, List<Booking>>> getUpcomingBookings() async {
   try{
     var response = await DioHelper.getData(path: EndPoints.getUpcomingBookings);
     List<Booking> bookings = (response.data as List).map((e) => Booking.fromJson(e)).toList();
     return Right(bookings);
   }
   on DioException catch (e){
     return Left(e);
   }
   on Exception catch (e){
     return Left(e);
   }

 }
  Future<Either<Exception, Unit>> addBooking(
      {required PlaceBooking booking,
      required int placeId,
      required int ownerId}) async {
    try {
      DioHelper.postData(
        path: "${EndPoints.bookPlace}${ConstantsManager.userId}",
        data: booking.toJson(
            stadiumId: placeId, reservationPrice: booking.reservationPrice!),
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }
  Future<Either<Exception, Unit>> cancelBooking(
      {required int bookingId}) async {
    try {
      DioHelper.postData(
        path: "${EndPoints.bookPlace}$bookingId",
        query: {"bookingId": bookingId},
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, List<AppFeedBack>>> getPlaceReviews(
      {required int placeId}) async {
    try {
      var response = await DioHelper.getData(
        path: EndPoints.getPlaceFeedbacks + placeId.toString(),
        query: {"stadiumId": placeId},
      );
      List<AppFeedBack> appFeedBacks = (response.data["reviews"] as List)
          .map((e) => AppFeedBack.fromJson(e))
          .toList();
      return Right(appFeedBacks);
    } on DioException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> addPlaceToFavorite(
      {required int placeId}) async {
    try {
      await DioHelper.postData(
        path: "${EndPoints.addPlaceToFavourites}${ConstantsManager.userId}",
        data: {"stadiumId": placeId},
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> removePlaceFromFavorite(
      {required int placeId}) async {
    try {
      await DioHelper.deleteData(
        path:
            "${EndPoints.deletePlaceFromFavourites}${ConstantsManager.userId}",
        data: {"stadiumId": placeId},
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> addOwnerFeedback(int playerId,
      {required AppFeedBack review}) async {
    try {
      await DioHelper.postData(
        data: review.toJson(userType: "owner"),
        path: EndPoints.addOwnerFeedback + playerId.toString(),
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> addPlayerFeedback(int playerId,
      {required AppFeedBack review}) async {
    try {
      await DioHelper.postData(
        data: review.toJson(userType: "owner"),
        path: EndPoints.addPlayerFeedback + playerId.toString(),
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }
  Future<Either<Exception, Unit>> addPlaceFeedback(int placeId,
      {required AppFeedBack review}) async {
    try {
      await DioHelper.postData(
        data: review.toJson(userType: "player"),
        path: EndPoints.addPlaceFeedback + placeId.toString(),
        query: {"stadiumId": placeId},
      );
      return const Right(unit);
    } on DioException catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(e);
    }
  }


  Future _sendNotificationToOwner(int ownerId, int placeId) async {
    AppNotification notification = AppNotification(
        image: ConstantsManager.appUser!.profilePictureUrl ,
        body: "طلب ${ConstantsManager.appUser!.userName} حجز ملعبك ",
        receiverId: ownerId,
        title: "طلب حجز ملعب",
        dateTime: DateTime.now(),
        id: 0);

    NotificationServices().sendNotification(notification);
  }
}
