import 'dart:io';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';

class User {
  final int id;
  final String userName;
  final int approvalStatus;
  final double? rate;
  final String? profilePictureUrl;
  final String? proofOfIdentityUrl;
  final List<AppFeedBack> feedbacks;

  User({
    required this.id,
    required this.userName,
    required this.approvalStatus,
    required this.profilePictureUrl,
    required this.feedbacks,
    this.proofOfIdentityUrl,
    required this.rate,
  });

}
