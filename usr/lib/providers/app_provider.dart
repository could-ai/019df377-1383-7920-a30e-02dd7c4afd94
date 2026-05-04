import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../services/database_service.dart';

class AppProvider with ChangeNotifier {
  final DatabaseService _db = DatabaseService.instance;
  
  List<Tool> _tools = [];
  List<Battery> _batteries = [];
  List<Charger> _chargers = [];
  List<MaintenanceRecord> _maintenanceRecords = [];
  List<BorrowRecord> _borrowRecords = [];
  
  bool _isLoading = true;
  bool _isPro = false;
  
  // Getters
  List<Tool> get tools => _tools;
  List<Battery> get batteries => _batteries;
  List<Charger> get chargers => _chargers;
  List<MaintenanceRecord> get maintenanceRecords => _maintenanceRecords;
  List<BorrowRecord> get borrowRecords => _borrowRecords;
  
  bool get isLoading => _isLoading;
  bool get isPro => _isPro;
  
  // Dashboard stats
  int get totalTools => _tools.length;
  double get totalToolValue => _tools.fold(0, (sum, tool) => sum + (tool.price ?? 0));
  int get totalBatteries => _batteries.length;
  int get totalSpecialtyTools => _tools.where((t) => t.category == 'Specialty Kits' || t.category == 'Specialty Tools').length;
  int get currentlyBorrowed => _borrowRecords.where((r) => r.returnDate == null).length;
  
  int get maintenanceDue {
    final now = DateTime.now();
    return _maintenanceRecords.where((r) {
      if (r.nextDueDate == null) return false;
      return r.nextDueDate!.isBefore(now) || r.nextDueDate!.difference(now).inDays <= 7;
    }).length;
  }
  
  int get calibrationDue {
    final now = DateTime.now();
    return _tools.where((t) {
      if (t.calibrationDate == null) return false;
      // Assuming calibration is needed every year
      final nextCal = DateTime(t.calibrationDate!.year + 1, t.calibrationDate!.month, t.calibrationDate!.day);
      return nextCal.isBefore(now) || nextCal.difference(now).inDays <= 30;
    }).length;
  }
  
  int get warrantyExpiring {
    final now = DateTime.now();
    return _tools.where((t) {
      if (t.warrantyExpiry == null) return false;
      return t.warrantyExpiry!.isAfter(now) && t.warrantyExpiry!.difference(now).inDays <= 30;
    }).length;
  }
  
  AppProvider() {
    _init();
  }
  
  Future<void> _init() async {
    _isLoading = true;
    notifyListeners();
    
    await checkProStatus();
    await loadData();
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> checkProStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _isPro = prefs.getBool('is_pro') ?? false;
  }
  
  Future<void> upgradeToPro() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_pro', true);
    _isPro = true;
    notifyListeners();
  }
  
  Future<void> loadData() async {
    _tools = await _db.getTools();
    _batteries = await _db.getBatteries();
    _chargers = await _db.getChargers();
    _maintenanceRecords = await _db.getMaintenanceRecords();
    _borrowRecords = await _db.getBorrowRecords();
    notifyListeners();
  }
  
  // Check limit for free version
  bool canAddTool() {
    if (_isPro) return true;
    return _tools.length < 50;
  }
  
  // Tool Operations
  Future<void> addTool(Tool tool) async {
    if (!canAddTool()) throw Exception('Free limit reached');
    await _db.insertTool(tool);
    await loadData();
  }
  
  Future<void> updateTool(Tool tool) async {
    await _db.updateTool(tool);
    await loadData();
  }
  
  Future<void> deleteTool(String id) async {
    await _db.deleteTool(id);
    await loadData();
  }
  
  // Battery Operations
  Future<void> addBattery(Battery battery) async {
    await _db.insertBattery(battery);
    await loadData();
  }
  
  Future<void> updateBattery(Battery battery) async {
    await _db.updateBattery(battery);
    await loadData();
  }
  
  Future<void> deleteBattery(String id) async {
    await _db.deleteBattery(id);
    await loadData();
  }
  
  // Charger Operations
  Future<void> addCharger(Charger charger) async {
    await _db.insertCharger(charger);
    await loadData();
  }
  
  Future<void> updateCharger(Charger charger) async {
    await _db.updateCharger(charger);
    await loadData();
  }
  
  Future<void> deleteCharger(String id) async {
    await _db.deleteCharger(id);
    await loadData();
  }
  
  // Borrow/Lend Operations
  Future<void> addBorrowRecord(BorrowRecord record) async {
    await _db.insertBorrowRecord(record);
    // Update tool status
    final tool = _tools.firstWhere((t) => t.id == record.toolId);
    await updateTool(tool.copyWith(status: 'Borrowed'));
  }
  
  Future<void> returnTool(String recordId) async {
    final record = _borrowRecords.firstWhere((r) => r.id == recordId);
    final updatedRecord = record.copyWith(returnDate: DateTime.now());
    await _db.updateBorrowRecord(updatedRecord);
    
    // Update tool status
    final tool = _tools.firstWhere((t) => t.id == record.toolId);
    await updateTool(tool.copyWith(status: 'Available'));
  }
  
  // Maintenance Operations
  Future<void> addMaintenanceRecord(MaintenanceRecord record) async {
    await _db.insertMaintenanceRecord(record);
    await loadData();
  }
}
