import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../configs/localization/app_localizations.dart';
import '../../../core/locale/locale_cubit.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.language,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.change_language,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      RadioListTile<String>(
                        title: Text(
                          l10n.arabic,
                          style: const TextStyle(fontSize: 16),
                        ),
                        value: 'ar',
                        groupValue: state.locale.languageCode,
                        activeColor: Colors.teal,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<LocaleCubit>().changeLocale(value);
                          }
                        },
                      ),
                      const Divider(height: 1),
                      RadioListTile<String>(
                        title: Text(
                          l10n.english,
                          style: const TextStyle(fontSize: 16),
                        ),
                        value: 'en',
                        groupValue: state.locale.languageCode,
                        activeColor: Colors.teal,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<LocaleCubit>().changeLocale(value);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
