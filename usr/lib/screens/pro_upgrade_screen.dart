import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProUpgradeScreen extends StatelessWidget {
  const ProUpgradeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upgrade to Pro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.workspace_premium, size: 80, color: AppTheme.accentColor),
            const SizedBox(height: 16),
            const Text(
              'ToolVault Pro',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Unlock full potential for professional mechanics.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 32),
            _buildFeature('Unlimited Tools & Batteries', Icons.all_inclusive),
            _buildFeature('Cloud Backup & Sync', Icons.cloud_sync),
            _buildFeature('Advanced Reporting & Export', Icons.picture_as_pdf),
            _buildFeature('Barcode & QR Scanning', Icons.qr_code_scanner),
            _buildFeature('Team & Shop Sharing', Icons.people),
            const SizedBox(height: 32),
            Card(
              color: AppTheme.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Monthly Plan', style: TextStyle(fontSize: 18, color: Colors.white70)),
                    const SizedBox(height: 8),
                    const Text('\$4.99 / mo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.accentColor)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        minimumSize: const Size.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('In-app purchases not implemented in demo')),
                        );
                      },
                      child: const Text('Subscribe Monthly', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: AppTheme.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Yearly Plan (Save 20%)', style: TextStyle(fontSize: 18, color: Colors.white70)),
                    const SizedBox(height: 8),
                    const Text('\$49.99 / yr', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.accentColor)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.cardColor,
                        side: const BorderSide(color: AppTheme.accentColor, width: 2),
                        minimumSize: const Size.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('In-app purchases not implemented in demo')),
                        );
                      },
                      child: const Text('Subscribe Yearly', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.accentColor)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.accentColor),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
