import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String name;
  final String description;
  final List<String> images;
  final int id;
  final int ownerId;

  const Place({
    required this.ownerId,
    required this.name,
    required this.description,
    required this.images,
    required this.id,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      ownerId: json['owner_id'],
      name: json['name'],
      description: json['description'],
      images: json['images'],
      id: json['id'],
    );
  }
  @override
  List<Object?> get props => [];
}
