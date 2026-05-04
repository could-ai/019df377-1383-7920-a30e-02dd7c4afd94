import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/start_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/tools_screen.dart';
import 'screens/batteries_screen.dart';
import 'screens/chargers_screen.dart';
import 'screens/specialty_tools_screen.dart';
import 'screens/maintenance_screen.dart';
import 'screens/borrow_lend_screen.dart';
import 'screens/search_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/pro_upgrade_screen.dart';
import 'screens/edit_tool_screen.dart';
import 'screens/edit_battery_screen.dart';
import 'screens/edit_charger_screen.dart';
import 'screens/export_backup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const ToolVaultProApp(),
    ),
  );
}

class ToolVaultProApp extends StatelessWidget {
  const ToolVaultProApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToolVault Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/start': (context) => const StartScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/tools': (context) => const ToolsScreen(),
        '/add-tool': (context) => const EditToolScreen(),
        '/batteries': (context) => const BatteriesScreen(),
        '/add-battery': (context) => const EditBatteryScreen(),
        '/chargers': (context) => const ChargersScreen(),
        '/add-charger': (context) => const EditChargerScreen(),
        '/specialty-tools': (context) => const SpecialtyToolsScreen(),
        '/maintenance': (context) => const MaintenanceScreen(),
        '/borrow': (context) => const BorrowLendScreen(),
        '/search': (context) => const SearchScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/upgrade': (context) => const ProUpgradeScreen(),
        '/export': (context) => const ExportBackupScreen(),
      },
    );
  }
}
