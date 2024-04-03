import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hawihub/src/core/apis/end_points.dart';
import 'package:hawihub/src/core/local/shared_prefrences.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
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
        ConstantsManager.userId = response.data['data']['id'];
        ConstantsManager.userToken = response.data['token'].toString();
        await CacheHelper.saveData(key: 'token', value: response.data['token']);
        await CacheHelper.saveData(
            key: 'id', value: response.data['data']['id']);
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
      if (response.statusCode == 200) {
        ConstantsManager.userId = response.data['data']['id'];
        ConstantsManager.userToken = response.data['token'].toString();
        await CacheHelper.saveData(key: 'token', value: response.data['token']);
        await CacheHelper.saveData(
            key: 'id', value: response.data['data']['id']);
        return "Login Successfully";
      }
      return (response.data['msg']);
    } catch (e) {
      return "Invalid username or password";
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
      return "No account for this user";
    } catch (e) {
      print("object $e");
      return e.toString();
    }
  }

  Future<String> changeProfileImage(String newProfileImage) async {
    try {
      Response response = await DioHelper.putData(
        token: ConstantsManager.userToken,
        data: {
          'image': newProfileImage,
        },
        path: EndPoints.changeProfile,
      );
      if (response.statusCode == 200) {
        return "Profile image updated successfully";
      }
      return (response.data['msg']);
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> deleteProfileImage() async {
    try {
      Response response = await DioHelper.deleteData(
        token: ConstantsManager.userToken,
        path: EndPoints.deleteProfile,
      );
      if (response.statusCode == 200) {
        return "Profile image deleted";
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

  Future<Either<String, Player>> getProfile(int id) async {
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
