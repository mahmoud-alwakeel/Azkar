import 'package:flutter/material.dart';
import 'configs/localization/app_localizations.dart';
import 'features/azkar/presentation/screens/azkar_screen.dart';
import 'features/settings/presentation/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.home_screen_title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settings,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              l10n.select_azkar_type,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[700],
                  ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: [
                  _buildAzkarCategoryCard(
                    context: context,
                    l10n: l10n,
                    title: l10n.morning_azkar,
                    description: l10n.morning_azkar_description,
                    icon: Icons.wb_sunny,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AzkarScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildAzkarCategoryCard(
                    context: context,
                    l10n: l10n,
                    title: l10n.evening_azkar,
                    description: l10n.evening_azkar_description,
                    icon: Icons.nights_stay,
                    color: Colors.indigo,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AzkarScreen(azkarType: 'evening'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildAzkarCategoryCard(
                    context: context,
                    l10n: l10n,
                    title: l10n.after_prayer_azkar,
                    description: l10n.after_prayer_azkar_description,
                    icon: Icons.mosque,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AzkarScreen(azkarType: 'after_prayer'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildAzkarCategoryCard(
                    context: context,
                    l10n: l10n,
                    title: l10n.duaa_from_quran,
                    description: l10n.duaa_from_quran_description,
                    icon: Icons.menu_book,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AzkarScreen(azkarType: 'duaa_from_quran'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAzkarCategoryCard({
    required BuildContext context,
    required AppLocalizations l10n,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isComingSoon = false,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.7),
                color.withValues(alpha: 0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  if (isComingSoon)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        l10n.coming_soon,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}