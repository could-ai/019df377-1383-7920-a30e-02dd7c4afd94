import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class ToolsScreen extends StatefulWidget {
  const ToolsScreen({super.key});

  @override
  State<ToolsScreen> createState() => _ToolsScreenState();
}

class _ToolsScreenState extends State<ToolsScreen> {
  String _searchQuery = '';
  String? _selectedCategory;
  
  final List<String> _categories = [
    'Hand Tools', 'Power Tools', 'Air Tools', 'Diagnostic Tools',
    'Diesel Tools', 'Electrical Tools', 'Fabrication Tools', 'Welding Tools',
    'A/C Tools', 'Torque Tools', 'Hydraulic Tools', 'Accessories'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOOL INVENTORY'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.accentOrange));
          }

          var tools = provider.tools;
          
          if (_selectedCategory != null) {
            tools = tools.where((t) => t.category == _selectedCategory).toList();
          }

          if (tools.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.build, size: 80, color: Colors.grey.withOpacity(0.3)),
                  const SizedBox(height: 16),
                  Text(
                    'NO TOOLS FOUND',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text('Tap the + button to add a tool to your inventory.',
                    style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tools.length,
            itemBuilder: (context, index) {
              final tool = tools[index];
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
                      image: tool.photoPath != null && tool.photoPath!.isNotEmpty
                          ? DecorationImage(
                              image: FileImage(File(tool.photoPath!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: tool.photoPath == null || tool.photoPath!.isEmpty
                        ? const Icon(Icons.handyman, color: AppTheme.textGray)
                        : null,
                  ),
                  title: Text(tool.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('${tool.brand} • ${tool.category}'),
                      if (tool.location != null && tool.location!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 14, color: AppTheme.accentOrange),
                            const SizedBox(width: 4),
                            Text(tool.location!),
                          ],
                        ),
                      ],
                    ],
                  ),
                  trailing: tool.status == 'Borrowed' 
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.accentOrange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppTheme.accentOrange),
                        ),
                        child: const Text('OUT', style: TextStyle(color: AppTheme.accentOrange, fontWeight: FontWeight.bold, fontSize: 12)),
                      )
                    : const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {
                    Navigator.pushNamed(context, '/tools/edit', arguments: tool);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final provider = Provider.of<AppProvider>(context, listen: false);
          if (!provider.isPro && provider.tools.length >= 50) {
            Navigator.pushNamed(context, '/upgrade');
          } else {
            Navigator.pushNamed(context, '/tools/edit');
          }
        },
        backgroundColor: AppTheme.accentOrange,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('ADD TOOL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('FILTER INVENTORY'),
          content: DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Category'),
            value: _selectedCategory,
            items: [
              const DropdownMenuItem(value: null, child: Text('All Categories')),
              ..._categories.map((c) => DropdownMenuItem(value: c, child: Text(c))),
            ],
            onChanged: (val) {
              setState(() {
                _selectedCategory = val;
              });
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
          ],
        );
      },
    );
  }
}
