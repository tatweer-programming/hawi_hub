import 'package:flutter/cupertino.dart';
import 'package:hawihub/src/modules/places/data/models/feedback.dart';

import '../../../../../generated/l10n.dart';
class User {
  final int id;
  final String userName;
  final int approvalStatus;
  final bool? emailConfirmed;
  final double rate;
  final String? profilePictureUrl;
  final String? proofOfIdentityUrl;
  List<AppFeedBack> feedbacks;

  User({
    required this.id,
    required this.userName,
    required this.approvalStatus,
    required this.profilePictureUrl,
    required this.feedbacks,
    this.proofOfIdentityUrl,
    this.emailConfirmed,
    required this.rate,
  });
}
