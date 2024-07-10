import 'package:bloc/bloc.dart';
import 'package:hawihub/src/core/common%20widgets/common_widgets.dart';
import 'package:hawihub/src/core/error/exception_manager.dart';
import 'package:hawihub/src/core/error/user_access_error.dart';

import '../utils/constance_manager.dart';

enum AccessCheckType {
  balance,
  age,
  login,
  verification,
}

class UserAccessProxy {
  final double? requiredBalance;
  final double? requiredAgeRange;
  final Bloc bloc;
  final Object event;

  UserAccessProxy(this.bloc, this.event,
      {this.requiredBalance, this.requiredAgeRange});

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
    print(
        "(((((((((((((((((((((((((((((((((((((((balance)))))))))))))))))))))))))))))))))))))))");
    print(ConstantsManager.appUser!.myWallet.toString());
    return ConstantsManager.appUser!.myWallet >= requiredBalance!;
  }

  bool _isAgeSuitable({required double ageRange}) {
    int userAge = ConstantsManager.appUser!.getAge();
    print(userAge);
    double minAge = ageRange - 3;
    double maxAge = ageRange + 3;
    return userAge >= minAge && userAge <= maxAge;
  }

  void handleAccessException(
    UserAccessException exception,
  ) {
    errorToast(msg: ExceptionManager(exception).translatedMessage());
  }
}
