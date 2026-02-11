// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'Azkar';

  @override
  String get home_screen_title => 'Azkar';

  @override
  String get select_azkar_type => 'Choose Azkar Type';

  @override
  String get morning_azkar => 'Morning Azkar';

  @override
  String get morning_azkar_description => 'Prophetic morning supplications';

  @override
  String get evening_azkar => 'Evening Azkar';

  @override
  String get evening_azkar_description => 'Prophetic evening supplications';

  @override
  String get coming_soon => 'Coming Soon';

  @override
  String get reset_all => 'Reset All';

  @override
  String get reset_all_message => 'Do you want to reset all counters?';

  @override
  String get reset_single_message => 'Do you want to reset this azkar counter?';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get no_data => 'No data available';

  @override
  String get error_occurred => 'An error occurred';

  @override
  String get retry => 'Retry';

  @override
  String completed_of(int completed, int total) {
    return 'Completed $completed of $total';
  }

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get change_language => 'Change Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get morning_azkar_title => 'Morning Azkar';

  @override
  String get evening_azkar_title => 'Evening Azkar';
}
