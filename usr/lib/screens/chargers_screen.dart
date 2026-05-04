import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class ChargersScreen extends StatelessWidget {
  const ChargersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charger Inventory'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          final chargers = provider.chargers;
          
          if (chargers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.power, size: 80, color: Colors.grey.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  const Text(
                    'No chargers found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit_charger');
                    },
                    child: const Text('ADD CHARGER'),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: chargers.length,
            itemBuilder: (context, index) {
              final charger = chargers[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF2A2A2A),
                    child: Icon(Icons.power, color: Color(0xFFFF6D00)),
                  ),
                  title: Text('${charger.brand} ${charger.platform}'),
                  subtitle: Text('Type: ${charger.type}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Delete Charger?'),
                          content: const Text('Are you sure you want to delete this charger?'),
                          actions: [
                            TextButton(
                              child: const Text('CANCEL'),
                              onPressed: () => Navigator.of(ctx).pop(),
                            ),
                            TextButton(
                              child: const Text('DELETE', style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                provider.deleteCharger(charger.id);
                                Navigator.of(ctx).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/edit_charger',
                      arguments: charger,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/edit_charger');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
