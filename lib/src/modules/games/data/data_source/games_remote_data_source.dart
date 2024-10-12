import 'package:dartz/dartz.dart';
import 'package:hawihub/src/core/apis/dio_helper.dart';
import 'package:hawihub/src/core/apis/end_points.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:hawihub/src/modules/games/data/models/game_creation_form.dart';
import 'package:hawihub/src/modules/main/data/models/app_notification.dart';
import 'package:hawihub/src/modules/main/data/services/notification_services.dart';

class GamesRemoteDataSource {
  Future<Either<Exception, List<Game>>> getGames({required int cityId}) async {
    try {
      List<Game> games = [];
      var response = await DioHelper.getData(
          path: "${EndPoints.getGamesByCity}$cityId",
          query: {"cityId": cityId});

      games = (response.data as List).map((e) => Game.fromJson(e)).toList();
      return Right(games);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> createGame(
      {required GameCreationForm game}) async {
    try {
      var response = await DioHelper.postData(
          data: game.toJson(),
          path: EndPoints.createGame + ConstantsManager.userId.toString(),
          query: {"id": ConstantsManager.userId});

      return Right(response.data['gameId'].toString());
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> joinGame({
    required Game game,
    required double balance,
  }) async {
    try {
      Future.wait([
        DioHelper.postData(
            data: {"gameId": game.id},
            path: "${EndPoints.joinGame}${ConstantsManager.userId}",
            query: {"id": ConstantsManager.userId}),
        NotificationServices().sendNotification(AppNotification(
            title: "انضم ${ConstantsManager.appUser?.userName} الى حجزك",
            body:
                "انضم ${ConstantsManager.appUser?.userName} الى حجزك في  ${game.placeName}",
            id: 1,
            receiverId: game.host.id))
      ]);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Unit>> leaveGame({
    required int gameId,
  }) async {
    try {
      Future.wait([
        DioHelper.postData(
            data: {"gameId": gameId},
            path: "${EndPoints.leaveGame}${ConstantsManager.userId}",
            query: {"id": ConstantsManager.userId}),
      ]);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, Game>> getGame({required int gameId}) async {
    try {
      var response = await DioHelper.getData(
          path: "${EndPoints.getGameById}$gameId", query: {"id": gameId});

      return Right(Game.fromJson(response.data));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
