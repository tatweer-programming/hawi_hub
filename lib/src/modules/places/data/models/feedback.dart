import 'package:equatable/equatable.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';

class AppFeedBack extends Equatable {
  final int? id;
  final int? userId;
  final String? comment;
  String? userName;
  String? userImageUrl;
  final double rating;

  AppFeedBack({
    this.id,
    required this.userId,
    this.comment,
    this.userName,
    this.userImageUrl,
    required this.rating,
  });

  factory AppFeedBack.fromJson(Map<String, dynamic> json) {
    return AppFeedBack(
      id: json['reviewId'],
      userId: json['playerId'],
      comment: json['comment'],
      rating: json['rate'],
    );
  }

  Map<String, dynamic> toJson({required String userType}) {
    return {
      '${userType}Id': userId,
      'comment': comment,
      'rating': rating,
    };
  }

  factory AppFeedBack.create({
    String? comment,
    required double rating,
  }) {
    return AppFeedBack(
      comment: comment,
      rating: rating,
      userId: ConstantsManager.appUser!.id,
      userName: ConstantsManager.appUser!.userName,
    );
  }

  @override
  List<Object?> get props => [
        id,
      ];
}
