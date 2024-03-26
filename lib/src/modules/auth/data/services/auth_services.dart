import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hawihub/src/core/apis/end_points.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';

import '../../../../core/apis/dio_helper.dart';

class AuthService {
  Future<Either<Exception, String>> registerPlayer(
    Player player,
  ) async {
    try {
      Response? response;
      await DioHelper.postData(
        data: {
          'mail': player.email,
          'pass': player.password,
          'user_name': player.userName,
        },
        path: EndPoints.register,
      ).then((value) {
        response = value;
        print(response);
        if (kDebugMode) {
          print(response!.data['msg']);
        }
      });
      if (kDebugMode) {
        print(response!.statusCode);
      }

      return Right(response!.data['msg'] ?? "Registration Successful");
      // var response = await http
      //     .post(Uri.parse(ApiManager.baseUrl + EndPoints.login), body: {
      //   'mail': player.email,
      //   'pass': player.password,
      // });
      // request.fields['mail'] = player.email;
      // request.fields['pass'] = player.password!;
      // request.fields['user_name'] = player.userName;
      // var imageStream = http.ByteStream(
      //     player.profilePictureFile!.openRead().cast()); // Open a stream
      // var length =
      //     await player.profilePictureFile!.length(); // Get the image length
      // var multipartFile = http.MultipartFile(
      //   'image',
      //   imageStream,
      //   length,
      //   filename: 'user_image.jpg',
      // );
      //
      // request.files.add(multipartFile);
      // if (response.statusCode == 200) {
      //   // Registration successful
      //   // Handle successful registration response
      //   print('Registration Successful');
      // } else {
      //   // Registration failed
      //   // Handle failed registration response
      //   print('Registration Failed');
      // }
      // return Right(response.statusCode.toString());
    } on Exception catch (e) {
      print(e);
      return Left(e);
    }
  }

  Future<String> loginPlayer(String email, String password) async {
    try {
      // var response = await http
      //     .post(Uri.parse(ApiManager.baseUrl + EndPoints.login), body: {
      //   'mail': email,
      //   'pass': password,
      // });
      // if(response.statusCode == 200){
      //   print("object");
      //   return "Success";
      // }
      // return response.body;
      Response response = await DioHelper.postData(
        data: {
          'mail': email,
          'pass': password,
        },
        path: EndPoints.login,
      );
      print("response");
      print(response.statusCode);
      return response.data.toString();
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
