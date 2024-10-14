import 'package:hawihub/src/core/utils/localization_manager.dart';

abstract class UserAccessException implements Exception {
  String getErrorMessage();

  @override
  String toString() {
    return getErrorMessage();
  }

  String getCurrentLanguageCode() {
    return LocalizationManager.getCurrentLocale().languageCode;
  }
}

class NotLoggedInException extends UserAccessException {
  @override
  String getErrorMessage() {
    String languageCode = getCurrentLanguageCode();
    switch (languageCode) {
      case 'en':
        return 'User not logged in';
      case 'ar':
        return 'المستخدم غير مسجل الدخول';
      // أضف لغات أخرى هنا
      default:
        return 'User not logged in';
    }
  }
}

class InsufficientBalanceException extends UserAccessException {
  @override
  String getErrorMessage() {
    String languageCode = getCurrentLanguageCode();
    switch (languageCode) {
      case 'en':
        return 'Insufficient balance';
      case 'ar':
        return 'الرصيد غير كافي';
      // أضف لغات أخرى هنا
      default:
        return 'Insufficient balance';
    }
  }
}

class AccountNotActivatedException extends UserAccessException {
  @override
  String getErrorMessage() {
    String languageCode = getCurrentLanguageCode();
    switch (languageCode) {
      case 'en':
        return 'Account not activated';
      case 'ar':
        return 'الحساب غير مفعل';
      // أضف لغات أخرى هنا
      default:
        return 'Account not activated';
    }
  }
}

class AgeNotSuitableException extends UserAccessException {
  @override
  String getErrorMessage() {
    String languageCode = getCurrentLanguageCode();
    switch (languageCode) {
      case 'en':
        return 'Age not suitable for the team';
      case 'ar':
        return 'العمر لا يتناسب مع الفريق';
      default:
        return 'Age not suitable for the team';
    }
  }
}

class GenderNotSuitableException extends UserAccessException {
  @override
  String getErrorMessage() {
    String languageCode = getCurrentLanguageCode();
    switch (languageCode) {
      case 'en':
        return 'Gender not suitable';
      case 'ar':
        return "النوع غير مناسب";
      default:
        return 'Gender not suitable for the team';
    }
  }
}

class EmailNotVerifiedException extends UserAccessException {
  @override
  String getErrorMessage() {
    String languageCode = getCurrentLanguageCode();
    switch (languageCode) {
      case 'en':
        return 'Email not verified';
      case 'ar':
        return "البريد الالكتروني غير مفعل";
      default:
        return 'Email not verified';
    }
  }
}
