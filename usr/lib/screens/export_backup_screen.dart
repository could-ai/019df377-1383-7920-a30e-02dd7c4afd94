import 'package:flutter/material.dart';

class ExportBackupScreen extends StatelessWidget {
  const ExportBackupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export & Backup'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Export Data',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6D00),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.grid_on),
              title: const Text('Export to CSV'),
              subtitle: const Text('Spreadsheet format for Excel/Google Sheets'),
              trailing: const Icon(Icons.lock, size: 16),
              onTap: () {
                _showProDialog(context);
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Export to PDF'),
              subtitle: const Text('Professional report format'),
              trailing: const Icon(Icons.lock, size: 16),
              onTap: () {
                _showProDialog(context);
              },
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Backup & Restore',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6D00),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.backup),
              title: const Text('Create Backup'),
              subtitle: const Text('Save database to device storage'),
              trailing: const Icon(Icons.lock, size: 16),
              onTap: () {
                _showProDialog(context);
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.restore),
              title: const Text('Restore Backup'),
              subtitle: const Text('Load database from device storage'),
              trailing: const Icon(Icons.lock, size: 16),
              onTap: () {
                _showProDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }
  
  void _showProDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pro Feature'),
        content: const Text('This feature requires ToolVault Pro. Upgrade now to unlock exports and backups.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('LATER'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/upgrade');
            },
            child: const Text('UPGRADE'),
          ),
        ],
      ),
    );
  }
}
