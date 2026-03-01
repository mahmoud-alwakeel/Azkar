import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/azkar_category_model.dart';
import '../data/repository/azkar_repository.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  final AzkarRepository repository;

  AzkarCubit({required this.repository}) : super(AzkarInitial());

  Future<void> loadMorningAzkar() async {
    try {
      emit(AzkarLoading());
      final azkarCategory = await repository.getMorningAzkar();
      emit(AzkarLoaded(azkarCategory: azkarCategory));
    } catch (e) {
      emit(AzkarError(message: e.toString()));
    }
  }

  Future<void> loadEveningAzkar() async {
    try {
      emit(AzkarLoading());
      final azkarCategory = await repository.getEveningAzkar();
      emit(AzkarLoaded(azkarCategory: azkarCategory));
    } catch (e) {
      emit(AzkarError(message: e.toString()));
    }
  }

  Future<void> loadAfterPrayerAzkar() async {
    try {
      emit(AzkarLoading());
      final azkarCategory = await repository.getAfterPrayerAzkar();
      emit(AzkarLoaded(azkarCategory: azkarCategory));
    } catch (e) {
      emit(AzkarError(message: e.toString()));
    }
  }

  Future<void> loadDuaaFromQuran() async {
    try {
      emit(AzkarLoading());
      final azkarCategory = await repository.getDuaaFromQuran();
      emit(AzkarLoaded(azkarCategory: azkarCategory));
    } catch (e) {
      emit(AzkarError(message: e.toString()));
    }
  }

  void incrementCounter(int azkarId) {
    if (state is AzkarLoaded) {
      final currentState = state as AzkarLoaded;
      final updatedAzkar = currentState.azkarCategory.azkar.map((azkar) {
        if (azkar.id == azkarId && azkar.counter < azkar.repeat) {
          return azkar.copyWith(counter: azkar.counter + 1);
        }
        return azkar;
      }).toList();

      final updatedCategory = currentState.azkarCategory.copyWith(azkar: updatedAzkar);
      emit(AzkarLoaded(azkarCategory: updatedCategory));
    }
  }

  void resetCounter(int azkarId) {
    if (state is AzkarLoaded) {
      final currentState = state as AzkarLoaded;
      final updatedAzkar = currentState.azkarCategory.azkar.map((azkar) {
        if (azkar.id == azkarId) {
          return azkar.copyWith(counter: 0);
        }
        return azkar;
      }).toList();

      final updatedCategory = currentState.azkarCategory.copyWith(azkar: updatedAzkar);
      emit(AzkarLoaded(azkarCategory: updatedCategory));
    }
  }

  void resetAllCounters() {
    if (state is AzkarLoaded) {
      final currentState = state as AzkarLoaded;
      final updatedAzkar = currentState.azkarCategory.azkar.map((azkar) {
        return azkar.copyWith(counter: 0);
      }).toList();

      final updatedCategory = currentState.azkarCategory.copyWith(azkar: updatedAzkar);
      emit(AzkarLoaded(azkarCategory: updatedCategory));
    }
  }
}
