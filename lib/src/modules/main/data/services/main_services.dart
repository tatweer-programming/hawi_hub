import 'package:dartz/dartz.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/apis/dio_helper.dart';
import 'package:hawihub/src/core/apis/end_points.dart';
import 'package:hawihub/src/modules/main/data/models/sport.dart';

class MainServices {
  Future<Either<Exception, List<String>>> getBanners() async {
    try {
      List<String> banners = [];
      var response = await DioHelper.getData(path: EndPoints.getBanners);

      if (response.statusCode == 200 && response.data.isNotEmpty) {
        for (var item in response.data) {
          banners.add(ApiManager.handleImageUrl(
              ApiManager.handleImageUrl(item["bannerImageUrl"].toString())));
        }
      }
      return Right(banners);
    } on Exception {
      return const Right([]);
    }
  }

  Future<Either<Exception, List<Sport>>> getSports() async {
    try {
      List<Sport> sports = [];
      var response = await DioHelper.getData(path: EndPoints.getSports);
      if (response.statusCode == 200) {
        for (var item in response.data) {
          sports.add(Sport.fromJson(item));
        }
      }
      print(sports.map((e) => e.image));
      return Right(sports);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
