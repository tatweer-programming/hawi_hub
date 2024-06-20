import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hawihub/src/core/apis/dio_helper.dart';
import 'package:hawihub/src/core/apis/end_points.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/places/data/models/booking.dart';
import 'package:hawihub/src/modules/places/data/models/day.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';
import 'package:hawihub/src/modules/places/data/models/place_location.dart';

import '../../../games/data/data_source/games_remote_data_source.dart';
import '../models/place.dart';

class PlacesRemoteDataSource {
  Future<Either<Exception, List<Place>>> getAllPlaces(
      {required int cityId}) async {
    try {
      List<Place> places = [];
      var response = await DioHelper.getData(
          path: "${EndPoints.getPlaces}$cityId", query: {"cityId": cityId});
      if (response.statusCode == 200) {
        places = (response.data as List).map((e) => Place.fromJson(e)).toList();
        print("places $places");
      }
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

  Future<Either<Exception, List<Booking>>> getPlaceBookings(
      {required int placeId}) async {
    try {
      List<Booking> bookings = [];
      var response = await DioHelper.getData(
          path: "${EndPoints.getPlaceBookings}$placeId");
      if (response.statusCode == 200) {
        bookings =
            (response.data as List).map((e) => Booking.fromJson(e)).toList();
      }
      return Right(bookings);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> addBooking(
      {required Booking booking, required int placeId}) async {
    try {
      await DioHelper.postData(
          path: "${EndPoints.bookPlace}$placeId",
          data: booking.toJson(
              stadiumId: placeId, reservationPrice: booking.reservationPrice!));
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> ratePlace(
      {required AppFeedBack feedBack, required int placeId}) {
    throw UnimplementedError();
  }

  Future<Either<Exception, List<AppFeedBack>>> getPlaceReviews(
      {required int placeId}) async {
    try {
      List<AppFeedBack> appFeedBacks = [];
      var response = await DioHelper.getData(
          path: EndPoints.getPlaceFeedbacks + placeId.toString(),
          query: {"stadiumId": placeId});
      if (response.statusCode == 200) {
        appFeedBacks = (response.data["reviews"] as List)
            .map((e) => AppFeedBack.fromJson(e))
            .toList();
        print(appFeedBacks);
      }
      return Right(appFeedBacks);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> addPlaceToFavorite(
      {required int placeId}) async {
    try {
      await DioHelper.postData(
          path: "${EndPoints.addPlaceToFavourites}${ConstantsManager.userId}",
          data: {"stadiumId": placeId});
      return const Right(unit);
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
          data: {"stadiumId": placeId});
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> addOwnerFeedback(int playerId,
      {required AppFeedBack review}) async {
    try {
      print("                             **************");
      print(review.toJson(userType: "owner"));
      await DioHelper.postData(
          data: review.toJson(userType: "owner"),
          path: EndPoints.addOwnerFeedback + playerId.toString(), );
      return const Right(unit);
    } on DioException catch (e) {
      print(e.message);
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> addPlaceFeedback(int placeId,
      {required AppFeedBack review}) async {
    try {
      await DioHelper.postData(
          data: review.toJson(userType: "player"),
          path: EndPoints.addPlaceFeedback + placeId.toString(),
          query: {"stadiumId": placeId});
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
