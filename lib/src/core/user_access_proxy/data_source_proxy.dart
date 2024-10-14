import 'package:bloc/bloc.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/error/user_access_error.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';

import '../../modules/places/data/models/place.dart';
import '../utils/constance_manager.dart';

enum AccessCheckType {
  balance,
  age,
  login,
  verification,
  emailVerification,
  gender
}

class UserAccessProxy {
  final double? requiredBalance;
  final double? requiredAgeRange;
  final Gender? requiredGender;
  final Bloc bloc;
  final Object event;

  UserAccessProxy(this.bloc, this.event,
      {this.requiredBalance, this.requiredAgeRange, this.requiredGender});

  void execute(List<AccessCheckType> accessCheckTypes) {
    UserAccessException? exception;
    for (var accessCheckType in accessCheckTypes) {
      exception = _checkAccess(accessCheckType);
      if (exception != null) {
        break;
      }
    }
    if (exception != null) {
      handleAccessException(
        exception,
      );
    } else {
      bloc.add(event);
    }
  }

  UserAccessException? _checkAccess(AccessCheckType accessCheckType) {
    switch (accessCheckType) {
      case AccessCheckType.balance:
        return _isBalanceEnough(price: requiredBalance!)
            ? null
            : InsufficientBalanceException();
      case AccessCheckType.age:
        return _isAgeSuitable(ageRange: requiredAgeRange!)
            ? null
            : AgeNotSuitableException();
      case AccessCheckType.login:
        return _isUserLoggedIn() ? null : NotLoggedInException();
      case AccessCheckType.verification:
        return _isAccountVerified() ? null : AccountNotActivatedException();
      case AccessCheckType.emailVerification:
        return _isEmailVerified() ? null : EmailNotVerifiedException();
      case AccessCheckType.gender:
        return _isGenderSuitable(requiredGender: requiredGender!)
            ? null
            : GenderNotSuitableException();

      default:
        return null;
    }
  }

  bool _isUserLoggedIn() {
    return ConstantsManager.userId != null;
  }

  bool _isAccountVerified() {
    return ConstantsManager.appUser!.isVerified();
  }

  bool _isBalanceEnough({required double price}) {
    return ConstantsManager.appUser!.myWallet >= requiredBalance!;
  }

  bool _isAgeSuitable({required double ageRange}) {
    int userAge = ConstantsManager.appUser!.getAge();
    double minAge = ageRange - 3;
    double maxAge = ageRange + 3;
    return userAge >= minAge && userAge <= maxAge;
  }

  bool _isGenderSuitable({required Gender requiredGender}) {
    return ConstantsManager.appUser!.gender == requiredGender ||
        requiredGender == Gender.both;
  }

  bool _isEmailVerified() {
    Player player = ConstantsManager.appUser!;
    return player.isEmailConfirmed();
  }

  void handleAccessException(
    UserAccessException exception,
  ) {
    errorToast(msg: ExceptionManager(exception).translatedMessage());
  }
}
