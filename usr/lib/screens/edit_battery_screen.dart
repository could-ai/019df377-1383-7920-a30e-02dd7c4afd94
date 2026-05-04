import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';
import '../providers/app_provider.dart';

class EditBatteryScreen extends StatefulWidget {
  const EditBatteryScreen({super.key});

  @override
  State<EditBatteryScreen> createState() => _EditBatteryScreenState();
}

class _EditBatteryScreenState extends State<EditBatteryScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late String _id;
  late String _brand;
  late String _voltage;
  late String _ampHours;
  late String _platform;
  late String _condition;
  late int _purchaseDate;
  
  final _brandController = TextEditingController();
  final _voltageController = TextEditingController();
  final _ampHoursController = TextEditingController();
  final _platformController = TextEditingController();
  
  bool _isInit = true;
  bool _isNew = true;
  
  final List<String> _conditions = ['Excellent', 'Good', 'Fair', 'Poor', 'Dead'];
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final battery = ModalRoute.of(context)?.settings.arguments as Battery?;
      if (battery != null) {
        _isNew = false;
        _id = battery.id;
        _brandController.text = battery.brand;
        _voltageController.text = battery.voltage;
        _ampHoursController.text = battery.ampHours;
        _platformController.text = battery.platform;
        _condition = battery.condition;
        _purchaseDate = battery.purchaseDate;
      } else {
        _isNew = true;
        _id = const Uuid().v4();
        _condition = 'Good';
        _purchaseDate = DateTime.now().millisecondsSinceEpoch;
      }
      _isInit = false;
    }
  }
  
  @override
  void dispose() {
    _brandController.dispose();
    _voltageController.dispose();
    _ampHoursController.dispose();
    _platformController.dispose();
    super.dispose();
  }
  
  void _saveForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    final battery = Battery(
      id: _id,
      brand: _brandController.text.trim(),
      voltage: _voltageController.text.trim(),
      ampHours: _ampHoursController.text.trim(),
      platform: _platformController.text.trim(),
      condition: _condition,
      purchaseDate: _purchaseDate,
    );
    
    final provider = Provider.of<AppProvider>(context, listen: false);
    if (_isNew) {
      provider.addBattery(battery);
    } else {
      provider.updateBattery(battery);
    }
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'Add Battery' : 'Edit Battery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(
                  labelText: 'Brand',
                  prefixIcon: Icon(Icons.business),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a brand';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _voltageController,
                      decoration: const InputDecoration(
                        labelText: 'Voltage',
                        prefixIcon: Icon(Icons.bolt),
                        hintText: 'e.g. 18V',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _ampHoursController,
                      decoration: const InputDecoration(
                        labelText: 'Amp Hours (Ah)',
                        prefixIcon: Icon(Icons.battery_charging_full),
                        hintText: 'e.g. 5.0',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _platformController,
                decoration: const InputDecoration(
                  labelText: 'Battery Platform',
                  prefixIcon: Icon(Icons.category),
                  hintText: 'e.g. M18, 20V MAX',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a platform';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _condition,
                decoration: const InputDecoration(
                  labelText: 'Condition',
                  prefixIcon: Icon(Icons.health_and_safety),
                ),
                items: _conditions.map((condition) {
                  return DropdownMenuItem(
                    value: condition,
                    child: Text(condition),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) _condition = value;
                  });
                },
              ),
              const SizedBox(height: 32),
              
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: const Icon(Icons.save),
                label: const Text('SAVE BATTERY'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
