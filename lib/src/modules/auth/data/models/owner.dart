import 'package:hawihub/src/modules/auth/data/models/user.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';

class Owner extends User {
  Owner(
      {required super.id,
      required super.userName,
      required super.profilePictureUrl,
      required super.feedbacks,
      required super.approvalStatus,
      required super.proofOfIdentityUrl,
      required super.rate});

  factory Owner.fromJson(Map<String, dynamic> json) {
    List<AppFeedBack> feedbacks = List.from(json['reviews'] ?? [])
        .map((feedback) => AppFeedBack.fromJson(feedback))
        .toList();
    return Owner(
      approvalStatus: json['approvalStatus'],
      profilePictureUrl: json['profilePictureUrl'],
      id: json['id'],
      proofOfIdentityUrl: json['proofOfIdentityUrl'],
      userName: json['userName'],
      feedbacks: feedbacks,
      rate: json["rate"].toDouble(),
    );
  }
}
