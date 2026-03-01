import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configs/localization/app_localizations.dart';
import '../../data/datasource/azkar_local_datasource.dart';
import '../../data/repository/azkar_repository.dart';
import '../../logic/azkar_cubit.dart';
import '../widgets/azkar_card.dart';

class AzkarScreen extends StatelessWidget {
  final String azkarType;

  const AzkarScreen({super.key, this.azkarType = 'morning'});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) {
        final cubit = AzkarCubit(
          repository: AzkarRepository(
            datasource: AzkarLocalDatasource(),
          ),
        );

        if (azkarType == 'evening') {
          cubit.loadEveningAzkar();
        } else if (azkarType == 'after_prayer') {
          cubit.loadAfterPrayerAzkar();
        } else if (azkarType == 'duaa_from_quran') {
          cubit.loadDuaaFromQuran();
        } else {
          cubit.loadMorningAzkar();
        }

        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            azkarType == 'evening'
                ? l10n.evening_azkar
                : azkarType == 'after_prayer'
                    ? l10n.after_prayer_azkar
                    : azkarType == 'duaa_from_quran'
                        ? l10n.duaa_from_quran
                        : l10n.morning_azkar,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            if (azkarType != 'duaa_from_quran')
              BlocBuilder<AzkarCubit, AzkarState>(
                builder: (context, state) {
                  if (state is AzkarLoaded) {
                    return IconButton(
                      icon: const Icon(Icons.refresh),
                      tooltip: l10n.reset_all,
                      onPressed: () {
                        _showResetDialog(context, l10n);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
          ],
        ),
        body: BlocBuilder<AzkarCubit, AzkarState>(
          builder: (context, state) {
            if (state is AzkarLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is AzkarError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.error_occurred,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (azkarType == 'evening') {
                          context.read<AzkarCubit>().loadEveningAzkar();
                        } else if (azkarType == 'after_prayer') {
                          context.read<AzkarCubit>().loadAfterPrayerAzkar();
                        } else if (azkarType == 'duaa_from_quran') {
                          context.read<AzkarCubit>().loadDuaaFromQuran();
                        } else {
                          context.read<AzkarCubit>().loadMorningAzkar();
                        }
                      },
                      icon: const Icon(Icons.refresh),
                      label: Text(l10n.retry),
                    ),
                  ],
                ),
              );
            }

            if (state is AzkarLoaded) {
              final azkarList = state.azkarCategory.azkar;
              final isDuaaFromQuran = azkarType == 'duaa_from_quran';
              final completedCount = azkarList.where((a) => a.counter >= a.repeat).length;
              final totalCount = azkarList.length;

              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          state.azkarCategory.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        if (!isDuaaFromQuran) ...[
                          const SizedBox(height: 8),
                          Text(
                            l10n.completed_of(completedCount, totalCount),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: totalCount > 0 ? completedCount / totalCount : 0,
                              backgroundColor: Colors.white30,
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                              minHeight: 8,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      itemCount: azkarList.length,
                      itemBuilder: (context, index) {
                        final azkar = azkarList[index];
                        return AzkarCard(
                          azkar: azkar,
                          showSource: isDuaaFromQuran,
                          onTap: () {
                            context.read<AzkarCubit>().incrementCounter(azkar.id);
                          },
                          onLongPress: isDuaaFromQuran
                              ? null
                              : () {
                                  _showResetSingleDialog(context, azkar.id, l10n);
                                },
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return Center(
              child: Text(l10n.no_data),
            );
          },
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          l10n.reset_all,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        content: Text(
          l10n.reset_all_message,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AzkarCubit>().resetAllCounters();
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.reset),
          ),
        ],
      ),
    );
  }

  void _showResetSingleDialog(BuildContext context, int azkarId, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          l10n.reset,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        content: Text(
          l10n.reset_single_message,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AzkarCubit>().resetCounter(azkarId);
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.reset),
          ),
        ],
      ),
    );
  }
}
