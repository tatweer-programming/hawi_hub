import 'package:equatable/equatable.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';

class Place extends Equatable {
  final String name;
  final String description;
  final List<String> images;
  final String address;
  final int id;
  final int ownerId;
  int totalGames;
  int totalRatings;
  double? rating;
  final String longitudes;
  final String latitudes;
  final int minimumHours;
  final double price;
  List<DateTime> reservations;
  List<FeedBack> feedbacks;
  final String sport;
  final String ownerName;
  final String ownerImageUrl;
  Place({
    required this.ownerImageUrl,
    required this.ownerName,
    required this.sport,
    required this.price,
    required this.minimumHours,
    required this.longitudes,
    required this.latitudes,
    this.feedbacks = const [],
    this.reservations = const [],
    this.totalRatings = 0,
    required this.address,
    this.rating,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.images,
    required this.id,
    this.totalGames = 0,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      sport: json['sport'],
      price: json['price'],
      minimumHours: json['minimum_hours'],
      ownerImageUrl: json['owner_image_url'],
      ownerName: json['owner_name'],
      longitudes: json['longitudes'],
      latitudes: json['latitudes'],
      totalRatings: json['total_ratings'],
      totalGames: json['total_games'],
      ownerId: json['owner_id'],
      name: json['name'],
      description: json['description'],
      images: List.of(json['images']).map((e) => e.toString()).toList(),
      id: json['id'],
      rating: null,
      address: json['address'],
      reservations: List.of(json['reservations']).map((e) => DateTime.parse(e)).toList(),
      feedbacks: List.of(json['feedbacks']).map((e) => FeedBack.fromJson(e)).toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'sport': sport,
      'price': price,
      'minimum_hours': minimumHours,
      'longitudes': longitudes,
      'latitudes': latitudes,
      'total_ratings': totalRatings,
      'total_games': totalGames,
      'owner_id': ownerId,
      'name': name,
      'description': description,
      'images': images,
      'address': address,
      'reservations': reservations,
      'feedbacks': feedbacks,
    };
  }

  @override
  List<Object?> get props => [];
}
