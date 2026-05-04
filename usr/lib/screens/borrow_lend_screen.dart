import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

class BorrowLendScreen extends StatelessWidget {
  const BorrowLendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Borrowed Out Tools'),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          final borrowedTools = provider.tools.where((t) => t.isBorrowedOut).toList();
          
          if (borrowedTools.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.handshake, size: 80, color: Colors.grey.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  const Text(
                    'No tools currently borrowed out',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: borrowedTools.length,
            itemBuilder: (context, index) {
              final tool = borrowedTools[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF2A2A2A),
                    child: Icon(Icons.handyman, color: Color(0xFFFF6D00)),
                  ),
                  title: Text(tool.name),
                  subtitle: Text('Borrowed by: ${tool.borrowedTo}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      final returnedTool = tool.copyWith(
                        isBorrowedOut: false,
                        borrowedTo: null,
                        borrowedDate: null,
                      );
                      provider.updateTool(returnedTool);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${tool.name} marked as returned')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('RETURNED'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
