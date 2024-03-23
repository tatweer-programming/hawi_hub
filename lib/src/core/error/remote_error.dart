import '../utils/localization_manager.dart';

class ExceptionManager implements Exception {
  dynamic error;

  ExceptionManager(this.error);

  String translatedMessage() {
    if (LocalizationManager.getCurrentLocale().languageCode == "en") {
      return error.message;
    }
    switch (error.code) {
      case 400:
        return "طلب غير صالح";
      case 401:
        return "غير مصرح";
      case 403:
        return "ممنوع";
      case 404:
        return "غير موجود";
      case 405:
        return "الطريقة غير مسموح بها";
      case 406:
        return "غير مقبول";
      case 407:
        return "المصادقة بالوكيل مطلوبة";
      case 408:
        return "انتهت مهلة الطلب";
      case 409:
        return "تعارض";
      case 410:
        return "انتهى";
      case 411:
        return "الطول مطلوب";
      case 412:
        return "فشلت الشروط الأولية";
      case 413:
        return "حمولة كبيرة جدا";
      case 414:
        return "رابط طويل جدا";
      case 415:
        return "نوع الوسائط غير مدعوم";
      case 416:
        return "المجموعة غير مرضية";
      case 417:
        return "فشلت التوقعات";
      case 418:
        return "أنا إبريق";
      case 421:
        return "الطلب مضلل";
      case 422:
        return "المحتوى غير قابل للمعالجة";
      case 423:
        return "مغلق";
      case 424:
        return "فشل التبعية";
      case 425:
        return "مبكر جدًا";
      case 426:
        return "مطلوب الترقية";
      case 428:
        return "مطلوب شرط مسبق";
      case 429:
        return "الكثير من الطلبات";
      case 431:
        return "حقول رأس الطلب كبيرة جدًا";
      case 451:
        return "غير متوفر لأسباب قانونية";
      case 500:
        return "خطأ داخلي في الخادم";
      case 501:
        return "غير مُنفّذ";
      case 502:
        return "بوابة خادم غير صالحة";
      case 503:
        return "الخدمة غير متوفرة";
      case 504:
        return "مهلة البوابة المنتهية";
      case 505:
        return "النسخة غير مدعومة";
      case 506:
        return "البديل مفوض أيضًا";
      case 507:
        return "التخزين غير كافٍ";
      case 508:
        return "اكتشفت دورة مستمرة";
      case 510:
        return "غير موسع";
      case 511:
        return "مطلوب توثيق الشبكة";
      default:
        return "حدث خطأ غير متوقع";
    }
  }
}
