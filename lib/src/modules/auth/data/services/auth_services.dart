import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hawihub/src/core/apis/end_points.dart';
import 'package:hawihub/src/modules/auth/data/models/sport.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';

import '../../../../core/apis/dio_helper.dart';

class AuthService {
  Future<String> registerPlayer(
    Player player,
  ) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'mail': player.email,
          'pass': player.password,
          'user_name': player.userName,
        },
        path: EndPoints.register,
      );
      print(response);
      if (kDebugMode) {
        print("sssss${response.data['msg']}");
      }
      if (kDebugMode) {
        print(response.statusCode);
      }
      return (response.data['msg'] ?? "Registration Successful");
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> loginPlayer(String email, String password) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'mail': email,
          'pass': password,
        },
        path: EndPoints.login,
      );
      print(response.data.toString());
      return (response.data['msg'] ?? "Login Successfully");
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<Either<String, List<Sport>>> getSports() async {
    try {
      Response response = await DioHelper.getData(
        path: EndPoints.getSports,
      );
      print(response.data.toString());
      List<Sport> sports = [];
      for (var category in response.data) {
        sports.add(Sport.fromJson(category));
      }
      return Right(sports);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
