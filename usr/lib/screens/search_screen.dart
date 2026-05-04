import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search & Filter'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tools, batteries...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                ),
                filled: true,
                fillColor: AppTheme.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                _buildFilterChip('All'),
                _buildFilterChip('Tools'),
                _buildFilterChip('Batteries'),
                _buildFilterChip('Chargers'),
              ],
            ),
          ),
          Expanded(
            child: Consumer<AppProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator(color: AppTheme.accentColor));
                }

                List<dynamic> results = [];

                if (_selectedFilter == 'All' || _selectedFilter == 'Tools') {
                  results.addAll(provider.tools.where((t) =>
                      t.name.toLowerCase().contains(_searchQuery) ||
                      t.brand.toLowerCase().contains(_searchQuery)));
                }
                
                if (_selectedFilter == 'All' || _selectedFilter == 'Batteries') {
                  results.addAll(provider.batteries.where((b) =>
                      b.name.toLowerCase().contains(_searchQuery) ||
                      b.brand.toLowerCase().contains(_searchQuery)));
                }

                if (_selectedFilter == 'All' || _selectedFilter == 'Chargers') {
                  results.addAll(provider.chargers.where((c) =>
                      c.name.toLowerCase().contains(_searchQuery) ||
                      c.brand.toLowerCase().contains(_searchQuery)));
                }

                if (results.isEmpty) {
                  return const Center(child: Text('No results found.'));
                }

                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final item = results[index];
                    if (item is ToolItem) {
                      return ListTile(
                        leading: const Icon(Icons.build, color: AppTheme.accentColor),
                        title: Text(item.name),
                        subtitle: Text('${item.brand} - ${item.category}'),
                        onTap: () {
                          Navigator.pushNamed(context, '/add-tool', arguments: item);
                        },
                      );
                    } else if (item is BatteryItem) {
                      return ListTile(
                        leading: const Icon(Icons.battery_charging_full, color: Colors.green),
                        title: Text(item.name),
                        subtitle: Text('${item.brand} - ${item.voltage}V'),
                        onTap: () {
                          Navigator.pushNamed(context, '/add-battery', arguments: item);
                        },
                      );
                    } else if (item is ChargerItem) {
                      return ListTile(
                        leading: const Icon(Icons.electrical_services, color: Colors.orange),
                        title: Text(item.name),
                        subtitle: Text('${item.brand} - ${item.type}'),
                        onTap: () {
                          Navigator.pushNamed(context, '/add-charger', arguments: item);
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = label;
          });
        },
        selectedColor: AppTheme.accentColor.withOpacity(0.3),
        checkmarkColor: AppTheme.accentColor,
      ),
    );
  }
}
