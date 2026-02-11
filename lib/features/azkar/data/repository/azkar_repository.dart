import '../datasource/azkar_local_datasource.dart';
import '../models/azkar_category_model.dart';

class AzkarRepository {
  final AzkarLocalDatasource datasource;

  AzkarRepository({required this.datasource});

  Future<AzkarCategoryModel> getMorningAzkar() async {
    return await datasource.loadMorningAzkar();
  }

  Future<AzkarCategoryModel> getEveningAzkar() async {
    return await datasource.loadEveningAzkar();
  }

  Future<AzkarCategoryModel> getAfterPrayerAzkar() async {
    return await datasource.loadAfterPrayerAzkar();
  }

  Future<List<AzkarCategoryModel>> getAllAzkar() async {
    return await datasource.loadAllAzkar();
  }
}
