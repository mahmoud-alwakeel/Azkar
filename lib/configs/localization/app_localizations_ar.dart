// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get app_title => 'أذكار';

  @override
  String get home_screen_title => 'أذكار';

  @override
  String get select_azkar_type => 'اختر نوع الأذكار';

  @override
  String get morning_azkar => 'أذكار الصباح';

  @override
  String get morning_azkar_description =>
      'الأذكار المأثورة عن النبي ﷺ في الصباح';

  @override
  String get evening_azkar => 'أذكار المساء';

  @override
  String get evening_azkar_description =>
      'الأذكار المأثورة عن النبي ﷺ في المساء';

  @override
  String get coming_soon => 'قريباً';

  @override
  String get reset_all => 'إعادة تعيين الكل';

  @override
  String get reset_all_message => 'هل تريد إعادة تعيين جميع العدادات؟';

  @override
  String get reset_single_message => 'هل تريد إعادة تعيين عداد هذا الذكر؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get no_data => 'لا توجد بيانات';

  @override
  String get error_occurred => 'حدث خطأ';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String completed_of(int completed, int total) {
    return 'تم إنجاز $completed من $total';
  }

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get change_language => 'تغيير اللغة';

  @override
  String get english => 'English';

  @override
  String get arabic => 'العربية';

  @override
  String get morning_azkar_title => 'أذكار الصباح';

  @override
  String get evening_azkar_title => 'أذكار المساء';
}
