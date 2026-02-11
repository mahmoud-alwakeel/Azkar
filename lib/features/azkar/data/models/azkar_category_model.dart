import 'azkar_model.dart';

class AzkarCategoryModel {
  final String category;
  final String title;
  final List<AzkarModel> azkar;

  AzkarCategoryModel({
    required this.category,
    required this.title,
    required this.azkar,
  });

  factory AzkarCategoryModel.fromJson(Map<String, dynamic> json) {
    return AzkarCategoryModel(
      category: json['category'] as String,
      title: json['title'] as String,
      azkar: (json['azkar'] as List<dynamic>)
          .map((item) => AzkarModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'title': title,
      'azkar': azkar.map((item) => item.toJson()).toList(),
    };
  }

  AzkarCategoryModel copyWith({
    String? category,
    String? title,
    List<AzkarModel>? azkar,
  }) {
    return AzkarCategoryModel(
      category: category ?? this.category,
      title: title ?? this.title,
      azkar: azkar ?? this.azkar,
    );
  }
}
