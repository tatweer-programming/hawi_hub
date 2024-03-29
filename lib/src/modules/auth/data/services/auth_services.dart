import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hawihub/src/core/apis/end_points.dart';
import 'package:hawihub/src/modules/auth/data/models/sport.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';

import '../../../../core/apis/dio_helper.dart';

class AuthService {
  Future<String> registerPlayer({
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'mail': email,
          'user_name': userName,
          'pass': password,
        },
        path: EndPoints.register,
      );
      if (response.statusCode == 200) {
        return "Registration Successful";
      }
      return (response.data['msg']);
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
      String token = response.data['token'];
      int id = response.data['data']['id'];
      if (response.statusCode == 200) {
        return "Login Successfully";
      }
      return (response.data['msg']);
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> verifyCode(String email) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'mail': email,
        },
        path: EndPoints.verifyCode,
      );
      if (response.statusCode == 200) {
        return "Code Sent";
      }
      return (response.data['msg']);
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> resetPassword(
      {required String email,
      required String code,
      required String password}) async {
    try {
      Response response = await DioHelper.postData(
        data: {
          'mail': email,
          'code': code,
          'pass': password,
        },
        path: EndPoints.resetPass,
      );
      if (response.statusCode == 200) {
        return "Password Reset Successful";
      }
      return (response.data['msg']);
    } catch (e) {
      return e.toString();
    }
  }

  Future<Either<String, List<Sport>>> getSports() async {
    try {
      Response response = await DioHelper.getData(
        path: EndPoints.getSports,
      );
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

  Future<Either<String, Player>> getMyProfile(int id) async {
    try {
      Response response = await DioHelper.getData(
        path: "${EndPoints.getProfile}/$id",
      );
      Player player;
      player = Player.fromJson(response.data);
      return Right(player);
    } catch (e) {
      print(e);
      return Left(e.toString());
    }
  }
}
