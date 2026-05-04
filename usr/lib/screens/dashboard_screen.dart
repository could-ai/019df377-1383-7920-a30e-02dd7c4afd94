import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DASHBOARD'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, '/search'),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadData(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, provider),
                  const SizedBox(height: 24),
                  _buildQuickActions(context),
                  const SizedBox(height: 24),
                  Text(
                    'INVENTORY OVERVIEW',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildStatsGrid(context, provider),
                  const SizedBox(height: 24),
                  Text(
                    'ALERTS',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildAlerts(context, provider),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show bottom sheet to pick what to add
          showModalBottomSheet(
            context: context,
            backgroundColor: Theme.of(context).colorScheme.surface,
            builder: (context) => _buildAddMenu(context),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppProvider provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.steelBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TOTAL VAULT VALUE',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${provider.totalToolValue.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          if (!provider.isPro)
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/upgrade'),
              icon: const Icon(Icons.workspace_premium, size: 16),
              label: const Text('PRO'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                backgroundColor: Colors.amber[700],
                foregroundColor: Colors.black,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionBtn(context, Icons.handyman, 'Tools', '/tools'),
        _buildActionBtn(context, Icons.battery_charging_full, 'Batteries', '/batteries'),
        _buildActionBtn(context, Icons.build, 'Specialty', '/specialty-tools'),
        _buildActionBtn(context, Icons.swap_horiz, 'Borrow', '/borrow'),
      ],
    );
  }

  Widget _buildActionBtn(BuildContext context, IconData icon, String label, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.steelBorder),
              ),
              child: Icon(icon, color: Colors.grey[300]),
            ),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, AppProvider provider) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(context, 'Total Tools', provider.totalTools.toString(), Icons.handyman),
        _buildStatCard(context, 'Batteries', provider.totalBatteries.toString(), Icons.battery_full),
        _buildStatCard(context, 'Specialty Kits', provider.totalSpecialtyTools.toString(), Icons.cases),
        _buildStatCard(context, 'Borrowed Out', provider.currentlyBorrowed.toString(), Icons.people),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.steelBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.grey[400], size: 20),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[400],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlerts(BuildContext context, AppProvider provider) {
    return Column(
      children: [
        if (provider.maintenanceDue > 0)
          _buildAlertItem(
            context,
            'Maintenance Due',
            '${provider.maintenanceDue} tools require maintenance',
            Icons.build,
            Colors.orange,
            '/maintenance',
          ),
        if (provider.calibrationDue > 0)
          _buildAlertItem(
            context,
            'Calibration Due',
            '${provider.calibrationDue} tools require calibration',
            Icons.speed,
            Colors.red,
            '/tools', // Adjust routing as needed
          ),
        if (provider.warrantyExpiring > 0)
          _buildAlertItem(
            context,
            'Warranty Expiring',
            '${provider.warrantyExpiring} warranties expire soon',
            Icons.verified,
            Colors.yellow,
            '/tools',
          ),
        if (provider.maintenanceDue == 0 && provider.calibrationDue == 0 && provider.warrantyExpiring == 0)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.steelBorder),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green[400]),
                const SizedBox(width: 16),
                const Text('All systems normal. No pending alerts.'),
              ],
            ),
          )
      ],
    );
  }

  Widget _buildAlertItem(BuildContext context, String title, String subtitle, IconData icon, Color color, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }

  Widget _buildAddMenu(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'ADD TO INVENTORY',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.handyman),
            title: const Text('Add Tool'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/add-tool');
            },
          ),
          ListTile(
            leading: const Icon(Icons.battery_full),
            title: const Text('Add Battery'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/add-battery');
            },
          ),
          ListTile(
            leading: const Icon(Icons.electrical_services),
            title: const Text('Add Charger'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/add-charger'); // To be implemented
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
