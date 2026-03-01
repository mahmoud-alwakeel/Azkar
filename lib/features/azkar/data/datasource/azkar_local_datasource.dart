import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/azkar_category_model.dart';

class AzkarLocalDatasource {
  Future<AzkarCategoryModel> loadMorningAzkar() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/morning_azkar.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return AzkarCategoryModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load morning azkar: $e');
    }
  }

  Future<AzkarCategoryModel> loadEveningAzkar() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/evening_azkar.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return AzkarCategoryModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load evening azkar: $e');
    }
  }

  Future<AzkarCategoryModel> loadAfterPrayerAzkar() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/after_prayer_azkar.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return AzkarCategoryModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load after prayer azkar: $e');
    }
  }

  Future<AzkarCategoryModel> loadDuaaFromQuran() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/duaa_from_quran.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return AzkarCategoryModel.fromJson(jsonData);
    } catch (e) {
      throw Exception('Failed to load duaa from quran: $e');
    }
  }

  Future<List<AzkarCategoryModel>> loadAllAzkar() async {
    final morningAzkar = await loadMorningAzkar();
    final eveningAzkar = await loadEveningAzkar();
    final afterPrayerAzkar = await loadAfterPrayerAzkar();
    return [morningAzkar, eveningAzkar, afterPrayerAzkar];
  }
}
