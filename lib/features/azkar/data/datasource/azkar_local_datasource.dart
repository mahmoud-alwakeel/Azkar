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

  Future<List<AzkarCategoryModel>> loadAllAzkar() async {
    final morningAzkar = await loadMorningAzkar();
    return [morningAzkar];
  }
}
