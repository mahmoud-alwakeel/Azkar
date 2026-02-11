import '../datasource/azkar_local_datasource.dart';
import '../models/azkar_category_model.dart';

class AzkarRepository {
  final AzkarLocalDatasource datasource;

  AzkarRepository({required this.datasource});

  Future<AzkarCategoryModel> getMorningAzkar() async {
    return await datasource.loadMorningAzkar();
  }

  Future<List<AzkarCategoryModel>> getAllAzkar() async {
    return await datasource.loadAllAzkar();
  }
}
