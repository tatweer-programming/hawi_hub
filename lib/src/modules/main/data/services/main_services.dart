import 'package:dartz/dartz.dart';
import 'package:hawihub/src/core/apis/dio_helper.dart';
import 'package:hawihub/src/core/apis/end_points.dart';

class MainServices {
  Future<Either<Exception, List<String>>> getBanners() async {
    try {
      List<String> banners = [];
      var response = await DioHelper.getData(path: EndPoints.getBanners);
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          print(response.data[1]["img"].toString());
          for (var item in response.data) {
            if (item.containsKey('img')) {
              banners.add(item['img']);
            }
          }
        }
      }
      return Right(banners);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
