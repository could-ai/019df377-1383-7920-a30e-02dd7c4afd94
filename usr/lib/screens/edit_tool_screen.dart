import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import 'package:intl/intl.dart';

class EditToolScreen extends StatefulWidget {
  final Tool? tool; // If null, we are adding a new tool

  const EditToolScreen({super.key, this.tool});

  @override
  State<EditToolScreen> createState() => _EditToolScreenState();
}

class _EditToolScreenState extends State<EditToolScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _serialController;
  late TextEditingController _sizeController;
  late TextEditingController _locationController;
  late TextEditingController _priceController;
  late TextEditingController _notesController;
  
  String _category = 'Hand Tools';
  String _condition = 'Good';
  String _status = 'Available';
  DateTime? _warrantyExpiry;
  String? _photoPath;

  final List<String> _categories = [
    'Hand Tools', 'Power Tools', 'Air Tools', 'Diagnostic Tools',
    'Diesel Tools', 'Electrical Tools', 'Fabrication Tools', 'Welding Tools',
    'A/C Tools', 'Torque Tools', 'Hydraulic Tools', 'Accessories'
  ];

  final List<String> _conditions = ['New', 'Excellent', 'Good', 'Fair', 'Poor', 'Broken'];
  final List<String> _statuses = ['Available', 'In Use', 'Borrowed', 'Needs Repair'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.tool?.name ?? '');
    _brandController = TextEditingController(text: widget.tool?.brand ?? '');
    _modelController = TextEditingController(text: widget.tool?.model ?? '');
    _serialController = TextEditingController(text: widget.tool?.serialNumber ?? '');
    _sizeController = TextEditingController(text: widget.tool?.size ?? '');
    _locationController = TextEditingController(text: widget.tool?.location ?? '');
    _priceController = TextEditingController(
        text: widget.tool?.purchasePrice != null ? widget.tool!.purchasePrice.toString() : '');
    _notesController = TextEditingController(text: widget.tool?.notes ?? '');
    
    if (widget.tool != null) {
      if (_categories.contains(widget.tool!.category)) _category = widget.tool!.category;
      if (_conditions.contains(widget.tool!.condition)) _condition = widget.tool!.condition;
      if (_statuses.contains(widget.tool!.status)) _status = widget.tool!.status;
      _warrantyExpiry = widget.tool!.warrantyExpiry;
      _photoPath = widget.tool!.photoPath;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _serialController.dispose();
    _sizeController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    if (!provider.isPro) {
      Navigator.pushNamed(context, '/upgrade');
      return;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _photoPath = pickedFile.path;
      });
    }
  }

  void _saveTool() async {
    if (_formKey.currentState!.validate()) {
      final double? price = double.tryParse(_priceController.text);
      
      final newTool = Tool(
        id: widget.tool?.id,
        name: _nameController.text.trim(),
        category: _category,
        brand: _brandController.text.trim(),
        model: _modelController.text.trim(),
        serialNumber: _serialController.text.trim(),
        size: _sizeController.text.trim(),
        location: _locationController.text.trim(),
        condition: _condition,
        status: _status,
        purchasePrice: price,
        warrantyExpiry: _warrantyExpiry,
        photoPath: _photoPath,
        notes: _notesController.text.trim(),
        createdAt: widget.tool?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final provider = Provider.of<AppProvider>(context, listen: false);
      
      if (widget.tool == null) {
        await provider.addTool(newTool);
      } else {
        await provider.updateTool(newTool);
      }
      
      if (mounted) Navigator.pop(context);
    }
  }

  Future<void> _pickWarrantyDate() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    if (!provider.isPro) {
      Navigator.pushNamed(context, '/upgrade');
      return;
    }

    final date = await showDatePicker(
      context: context,
      initialDate: _warrantyExpiry ?? DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.accentOrange,
              onPrimary: Colors.white,
              surface: AppTheme.cardGray,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        _warrantyExpiry = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tool == null ? 'ADD TOOL' : 'EDIT TOOL'),
        actions: [
          if (widget.tool != null)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('DELETE TOOL?'),
                    content: const Text('This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('CANCEL'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        onPressed: () {
                          Provider.of<AppProvider>(context, listen: false)
                              .deleteTool(widget.tool!.id!);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('DELETE', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Photo picker
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.borderGray),
                  image: _photoPath != null && _photoPath!.isNotEmpty
                      ? DecorationImage(
                          image: FileImage(File(_photoPath!)),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _photoPath == null || _photoPath!.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.camera_alt, size: 48, color: AppTheme.textGray),
                          SizedBox(height: 8),
                          Text('TAP TO ADD PHOTO\n(PRO FEATURE)', 
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppTheme.textGray)),
                        ],
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 24),

            // Basic Info
            const Text('BASIC INFO', style: TextStyle(color: AppTheme.accentOrange, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Tool Name *'),
              validator: (val) => val == null || val.isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Category *'),
              value: _category,
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => _category = val!),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(labelText: 'Brand'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _sizeController,
                    decoration: const InputDecoration(labelText: 'Size (e.g. 10mm, 1/2")'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Identification
            const Text('IDENTIFICATION', style: TextStyle(color: AppTheme.accentOrange, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _modelController,
                    decoration: const InputDecoration(labelText: 'Model Number'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _serialController,
                    decoration: const InputDecoration(labelText: 'Serial Number'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Status & Location
            const Text('STATUS & LOCATION', style: TextStyle(color: AppTheme.accentOrange, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Condition'),
                    value: _condition,
                    items: _conditions.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (val) => setState(() => _condition = val!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Status'),
                    value: _status,
                    items: _statuses.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (val) => setState(() => _status = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                hintText: 'e.g. Top Drawer, Truck Bed, Service Cart',
              ),
            ),
            const SizedBox(height: 24),

            // Purchase & Warranty
            const Text('PURCHASE & WARRANTY', style: TextStyle(color: AppTheme.accentOrange, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Purchase Price (\$)',
                prefixText: '\$ ',
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _pickWarrantyDate,
              child: InputDecorator(
                decoration: const InputDecoration(labelText: 'Warranty Expiry (Pro Feature)'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_warrantyExpiry == null 
                        ? 'Not set' 
                        : DateFormat('MMM dd, yyyy').format(_warrantyExpiry!)),
                    const Icon(Icons.calendar_today, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Notes
            const Text('NOTES', style: TextStyle(color: AppTheme.accentOrange, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Additional Notes',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _saveTool,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentOrange,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('SAVE TOOL', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
