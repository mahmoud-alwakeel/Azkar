import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasource/azkar_local_datasource.dart';
import '../../data/repository/azkar_repository.dart';
import '../../logic/azkar_cubit.dart';
import '../widgets/azkar_card.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit(
        repository: AzkarRepository(
          datasource: AzkarLocalDatasource(),
        ),
      )..loadMorningAzkar(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'أذكار الصباح',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 0,
          actions: [
            BlocBuilder<AzkarCubit, AzkarState>(
              builder: (context, state) {
                if (state is AzkarLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.refresh),
                    tooltip: 'إعادة تعيين الكل',
                    onPressed: () {
                      _showResetDialog(context);
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
                      'حدث خطأ',
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
                        context.read<AzkarCubit>().loadMorningAzkar();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state is AzkarLoaded) {
              final azkarList = state.azkarCategory.azkar;
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
                        const SizedBox(height: 8),
                        Text(
                          'تم إنجاز $completedCount من $totalCount',
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
                          onTap: () {
                            context.read<AzkarCubit>().incrementCounter(azkar.id);
                          },
                          onLongPress: () {
                            _showResetSingleDialog(context, azkar.id);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const Center(
              child: Text('لا توجد بيانات'),
            );
          },
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'إعادة تعيين الكل',
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        content: const Text(
          'هل تريد إعادة تعيين جميع العدادات؟',
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
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
            child: const Text('إعادة تعيين'),
          ),
        ],
      ),
    );
  }

  void _showResetSingleDialog(BuildContext context, int azkarId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(
          'إعادة تعيين',
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        content: const Text(
          'هل تريد إعادة تعيين عداد هذا الذكر؟',
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
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
            child: const Text('إعادة تعيين'),
          ),
        ],
      ),
    );
  }
}
