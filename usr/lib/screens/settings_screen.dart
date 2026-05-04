import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.star, color: Color(0xFFFF6D00)),
            title: const Text('Upgrade to Pro'),
            subtitle: const Text('Unlock all features'),
            onTap: () {
              Navigator.pushNamed(context, '/upgrade');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.import_export),
            title: const Text('Export & Backup'),
            onTap: () {
              Navigator.pushNamed(context, '/export');
            },
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Dark Mode'),
            trailing: Switch(value: true, onChanged: null),
            subtitle: Text('Default industrial theme'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () {
              // Show privacy policy
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Privacy Policy'),
                  content: const SingleChildScrollView(
                    child: Text('We do not collect your personal tool data. All inventory data is stored locally on your device unless you manually backup or export it. In Pro version, backups may use external storage or cloud sync APIs.'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CLOSE'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Terms of Service'),
            onTap: () {
               showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Terms of Service'),
                  content: const SingleChildScrollView(
                    child: Text('ToolVault Pro is provided as-is. We are not responsible for lost data. Please backup regularly.'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CLOSE'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'ToolVault Pro',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.build, size: 48, color: Color(0xFFFF6D00)),
                children: [
                  const Text('The ultimate tool inventory tracker for mechanics and professionals.'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
