part of 'azkar_cubit.dart';

abstract class AzkarState {}

class AzkarInitial extends AzkarState {}

class AzkarLoading extends AzkarState {}

class AzkarLoaded extends AzkarState {
  final AzkarCategoryModel azkarCategory;

  AzkarLoaded({required this.azkarCategory});
}

class AzkarError extends AzkarState {
  final String message;

  AzkarError({required this.message});
}
