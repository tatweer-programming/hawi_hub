import 'package:equatable/equatable.dart';

class FeedBack extends Equatable {
  final int id;
  final int userId;
  final String? comment;
  final String userName;
  final String userImageUrl;
  final double rating;

  const FeedBack({
    required this.id,
    required this.userId,
    this.comment,
    required this.userName,
    required this.userImageUrl,
    required this.rating,
  });
  factory FeedBack.fromJson(Map<String, dynamic> json) {
    return FeedBack(
      id: json['id'],
      userId: json['user_id'],
      comment: json['comment'],
      userName: json['user_name'],
      userImageUrl: json['user_image_url'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'comment': comment,
      'rating': rating,
    };
  }

  @override
  List<Object?> get props => [
        id,
      ];
}
