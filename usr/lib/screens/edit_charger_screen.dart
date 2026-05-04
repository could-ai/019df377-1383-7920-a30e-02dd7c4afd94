import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';
import '../providers/app_provider.dart';

class EditChargerScreen extends StatefulWidget {
  const EditChargerScreen({super.key});

  @override
  State<EditChargerScreen> createState() => _EditChargerScreenState();
}

class _EditChargerScreenState extends State<EditChargerScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late String _id;
  late String _brand;
  late String _platform;
  late String _type;
  
  final _brandController = TextEditingController();
  final _platformController = TextEditingController();
  final _typeController = TextEditingController();
  
  bool _isInit = true;
  bool _isNew = true;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final charger = ModalRoute.of(context)?.settings.arguments as Charger?;
      if (charger != null) {
        _isNew = false;
        _id = charger.id;
        _brandController.text = charger.brand;
        _platformController.text = charger.platform;
        _typeController.text = charger.type;
      } else {
        _isNew = true;
        _id = const Uuid().v4();
      }
      _isInit = false;
    }
  }
  
  @override
  void dispose() {
    _brandController.dispose();
    _platformController.dispose();
    _typeController.dispose();
    super.dispose();
  }
  
  void _saveForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    final charger = Charger(
      id: _id,
      brand: _brandController.text.trim(),
      platform: _platformController.text.trim(),
      type: _typeController.text.trim(),
    );
    
    final provider = Provider.of<AppProvider>(context, listen: false);
    if (_isNew) {
      provider.addCharger(charger);
    } else {
      provider.updateCharger(charger);
    }
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'Add Charger' : 'Edit Charger'),
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
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(
                  labelText: 'Type (Fast, Dual, standard, etc.)',
                  prefixIcon: Icon(Icons.power),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a type';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _saveForm(),
              ),
              const SizedBox(height: 32),
              
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: const Icon(Icons.save),
                label: const Text('SAVE CHARGER'),
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
