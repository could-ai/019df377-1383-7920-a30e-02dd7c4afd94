import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class BatteriesScreen extends StatelessWidget {
  const BatteriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BATTERY INVENTORY'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.accentOrange));
          }

          final batteries = provider.batteries;

          if (batteries.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.battery_charging_full, size: 80, color: Colors.grey.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'NO BATTERIES FOUND',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text('Tap the + button to add a battery.',
                    style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: batteries.length,
            itemBuilder: (context, index) {
              final battery = batteries[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceDark,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppTheme.borderGray),
                    ),
                    child: const Icon(Icons.battery_std, color: AppTheme.accentOrange),
                  ),
                  title: Text('${battery.brand} ${battery.platform}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('${battery.voltage}V • ${battery.ampHours}Ah'),
                      const SizedBox(height: 4),
                      Text('Condition: ${battery.condition}'),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {
                    Navigator.pushNamed(context, '/batteries/edit', arguments: battery);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/batteries/edit');
        },
        backgroundColor: AppTheme.accentOrange,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('ADD BATTERY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
