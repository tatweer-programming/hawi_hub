import 'package:equatable/equatable.dart';

class Owner extends Equatable {
  final int id;
  final String name;
  final String bio;
  final String imageUrl;
  final double rating;

  const Owner({
    required this.id,
    required this.name,
    required this.bio,
    required this.imageUrl,
    required this.rating,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'],
      name: json['name'],
      bio: json['bio'],
      imageUrl: json['image_url'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'image_url': imageUrl,
      'rating': rating,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
