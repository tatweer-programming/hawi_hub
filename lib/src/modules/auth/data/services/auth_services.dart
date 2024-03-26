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
      FormData formData = FormData.fromMap({
        'mail': player.email,
        'pass': player.password,
        'user_name': player.userName,
        'image':
            "https://www.google.com/imgres?q=image&imgurl=https%3A%2F%2Fimages.ctfassets.net%2Fhrltx12pl8hq%2F28ECAQiPJZ78hxatLTa7Ts%2F2f695d869736ae3b0de3e56ceaca3958%2Ffree-nature-images.jpg%3Ffit%3Dfill%26w%3D1200%26h%3D630&imgrefurl=https%3A%2F%2Fwww.shutterstock.com%2Fdiscover%2Ffree-nature-images&docid=uEeA4F2Pf5UbvM&tbnid=0E5dDA82VanW3M&vet=12ahUKEwj0kpPV0JCFAxXOUqQEHblSC_sQM3oECGQQAA..i&w=1200&h=630&hcb=2&ved=2ahUKEwj0kpPV0JCFAxXOUqQEHblSC_sQM3oECGQQAA",
      });
      if (kDebugMode) {
        print(player.profilePictureFile);
      }

      Response? response;
      await DioHelper.postData(
        data: formData,
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

      return Right(response!.data['msg']);
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
    } catch (e) {
      print(e);
      return Left(Exception("String"));
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
      return response.data;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
