import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hawihub/src/core/apis/dio_helper.dart';
import 'package:hawihub/src/core/apis/end_points.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/games/data/models/game.dart';
import 'package:hawihub/src/modules/games/data/models/game_creation_form.dart';

import '../models/player.dart';

class GamesRemoteDataSource {


  Future<Either<Exception, List<Game>>> getGames({required int cityId}) async {
    try {
       List<Game> games = [];
  var response =    await DioHelper.getData(path: "${EndPoints.getGames}$cityId", query: {"cityId": cityId});

      if (response.statusCode == 200) {
        games = (response.data as List).map((e) => Game.fromJson(e)).toList();
        print(games);
      }

      return Right(games);
    } on Exception  catch (e) {
      return Left(e);
    }
  }

  Future<Either<Exception, String>> createGame({required GameCreationForm game})async {
    try {
      var response = await DioHelper.postData(data: game.toJson(), path: EndPoints.createGame + ConstantsManager.userId.toString() , query: {"id": ConstantsManager.userId});
      return Right(response.data['gameId'].toString());
    } on Exception catch (e) {
      DioException dioException = e as DioException;
      print(dioException.response!.data.toString()  + "    " + dioException.response!.statusCode.toString());
      return Left(e);
    }
  }
  Future<Either<Exception, Unit>> joinGame( {required int gameId})async {
       try {
         if (kDebugMode) {
           print(ConstantsManager.userId);
         }
         var response = await DioHelper.postData(data: {"gameId": gameId}, path: "${EndPoints.joinGame}${ConstantsManager.userId}",
             query: {"id": ConstantsManager.userId});
          if (response.statusCode == 200) {
            return const Right(unit);
          }

          return const Right(unit);
       } on Exception catch (e) {
         DioException dioException = e as DioException;
         print(dioException.response!.data  + "    " + dioException.response!.statusCode.toString());
         return Left(e);
       }
  }
}

Future<bool> startTimer(double seconds) async {
  int secondsInt = seconds.truncate();
  int milliseconds = ((seconds - secondsInt) * 1000).toInt();

  await Future.delayed(Duration(seconds: secondsInt, milliseconds: milliseconds));
  return true;
}
