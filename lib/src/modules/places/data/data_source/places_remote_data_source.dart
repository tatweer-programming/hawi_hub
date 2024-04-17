import 'package:dartz/dartz.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';

import '../../../games/data/data_source/games_remote_data_source.dart';
import '../models/place.dart';

class PlacesRemoteDataSource {
  Future<Either<Exception, List<Place>>> getAllPlaces() async {
    List<Place> places = [
      Place(
        latitudes: "",
        longitudes: "",
        totalGames: 122,
        totalRatings: 90,
        rating: 3.5,
        address: "Cairo - Borg El Arab Desert Road, Amreya - Alexandria Egypt",
        ownerId: 1,
        name: "Borg El Arab",
        description: "Borg El Arab is the most beautiful stadium in Egypt for football",
        images: const [
          "https://images.pexels.com/photos/46798/the-ball-stadion-football-the-pitch-46798.jpeg?auto=compress&cs=tinysrgb&w=400",
          "https://images.pexels.com/photos/399187/pexels-photo-399187.jpeg?auto=compress&cs=tinysrgb&w=400",
          "https://images.pexels.com/photos/61135/pexels-photo-61135.jpeg?auto=compress&cs=tinysrgb&w=400"
        ],
        id: 1,
        ownerImageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKYTt6cC8rwjl-DEuIPOY00lsOO6m7YuXejg&s',
        ownerName: 'State owned',
        sport: 'Football',
        price: 300,
        minimumHours: 2,
      ),
      // ملعب تنس
      Place(
        latitudes: "",
        longitudes: "",
        totalGames: 50,
        totalRatings: 45,
        rating: 4.0,
        address: "6th of October City, Egypt",
        ownerId: 2,
        name: "Cairo Tennis Club",
        description:
            "Cairo Tennis Club is one of the oldest and most prestigious tennis clubs in Egypt.",
        images: const [
          "https://images.pexels.com/photos/342361/pexels-photo-342361.jpeg?auto=compress&cs=tinysrgb&w=400",
          "https://images.pexels.com/photos/427649/pexels-photo-427649.jpeg?auto=compress&cs=tinysrgb&w=400",
          "https://images.pexels.com/photos/2961964/pexels-photo-2961964.jpeg?auto=compress&cs=tinysrgb&w=400"
        ],
        id: 2,
        ownerImageUrl:
            'https://images.pexels.com/photos/3785104/pexels-photo-3785104.jpeg?auto=compress&cs=tinysrgb&w=600',
        ownerName: 'Cairo Tennis Club',
        sport: 'Tennis',
        price: 200,
        minimumHours: 1,
      ),
      Place(
        latitudes: "",
        longitudes: "",
        totalGames: 20,
        totalRatings: 15,
        rating: 4.0,
        address: "Sheikh Zayed, Egypt",
        ownerId: 4,
        name: "Katameya Dunes Golf Course",
        description:
            "Katameya Dunes Golf Course is one of the most challenging and prestigious golf courses in Egypt.",
        images: const [
          "https://images.pexels.com/photos/114972/pexels-photo-114972.jpeg?auto=compress&cs=tinysrgb&w=400",
          "https://images.pexels.com/photos/2828723/pexels-photo-2828723.jpeg?auto=compress&cs=tinysrgb&w=400",
          "https://images.pexels.com/photos/54123/pexels-photo-54123.jpeg?auto=compress&cs=tinysrgb&w=400"
        ],
        id: 4,
        ownerImageUrl:
            'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=400',
        ownerName: 'Katameya Dunes Golf Course',
        sport: 'Golf',
        price: 400,
        minimumHours: 3,
      ),
      // ملعب سباحة
      Place(
        latitudes: "",
        longitudes: "",
        totalGames: 100,
        totalRatings: 80,
        rating: 4.5,
        address: "Heliopolis, Cairo, Egypt",
        ownerId: 5,
        name: "Cairo Olympic Club",
        description:
            "Cairo Olympic Club is one of the oldest and most prestigious sports clubs in Egypt.",
        images: const [
          "https://images.pexels.com/photos/863988/pexels-photo-863988.jpeg?auto=compress&cs=tinysrgb&w=400",
          "https://images.pexels.com/photos/261185/pexels-photo-261185.jpeg?auto=compress&cs=tinysrgb&w=400",
          "https://images.pexels.com/photos/1415810/pexels-photo-1415810.jpeg?auto=compress&cs=tinysrgb&w=600"
        ],
        id: 5,
        ownerImageUrl:
            'https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&w=600',
        ownerName: 'Cairo Olympic Club',
        sport: 'Swimming',
        price: 150,
        minimumHours: 1,
      ),
      // ملعب كرة طائرة
      Place(
        latitudes: "",
        longitudes: "",
        totalGames: 60,
        totalRatings: 50,
        rating: 4.0,
        address: "Al Ahly Club, Zamalek, Cairo, Egypt",
        ownerId: 6,
        name: "Al Ahly Club",
        description: "Al Ahly Club is one of the most successful sports clubs in Egypt and Africa.",
        images: const [
          "https://images.pexels.com/photos/6203675/pexels-photo-6203675.jpeg?auto=compress&cs=tinysrgb&w=600",
          "https://images.pexels.com/photos/1263426/pexels-photo-1263426.jpeg?auto=compress&cs=tinysrgb&w=600",
          "https://images.pexels.com/photos/6203594/pexels-photo-6203594.jpeg?auto=compress&cs=tinysrgb&w=600"
        ],
        id: 6,
        price: 100,
        ownerImageUrl: "https://cdn-bal.nba.com/manage/sites/3/2023/02/TEAM-LOGOS-900x506-11.jpg",
        ownerName: 'Al Ahly Club',
        sport: 'Volleyball',
        minimumHours: 1,
      )
    ];
    await startTimer(1.5);
    return Right(places);
  }

  Future<Either<Exception, Place>> getPlace({required int id}) {
    throw UnimplementedError();
  }

  Future<Either<Exception, List<DateTime>>> getCompletedDays({required int placeId}) {
    throw UnimplementedError();
  }

  Future<Either<Exception, List<DateTime>>> getDayBookings(
      {required DateTime date, required int placeId}) {
    throw UnimplementedError();
  }

  Future<Either<Exception, Unit>> ratePlace({required FeedBack feedBack, required int placeId}) {
    throw UnimplementedError();
  }

  Future<Either<Exception, List<FeedBack>>> getPlaceReviews({required int placeId}) {
    throw UnimplementedError();
  }
}
