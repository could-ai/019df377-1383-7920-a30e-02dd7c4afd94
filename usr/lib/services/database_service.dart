import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/models.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('toolvault.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT';
    const textNullable = 'TEXT NULL';
    const boolType = 'INTEGER NOT NULL';
    const intType = 'INTEGER';
    const intNullable = 'INTEGER NULL';
    const realType = 'REAL';
    const realNullable = 'REAL NULL';

    await db.execute('''
CREATE TABLE tools (
  id $idType,
  name $textType,
  brand $textType,
  category $textType,
  size $textNullable,
  model $textNullable,
  serialNumber $textNullable,
  location $textNullable,
  condition $textType,
  price $realNullable,
  purchaseDate $textNullable,
  warrantyMonths $intNullable,
  notes $textNullable,
  photoPath $textNullable,
  isBorrowed $boolType,
  borrowedTo $textNullable,
  borrowDate $textNullable,
  calibrationDate $textNullable,
  maintenanceIntervalMonths $intNullable,
  nextMaintenanceDate $textNullable,
  createdAt $textType
)
''');

    await db.execute('''
CREATE TABLE batteries (
  id $idType,
  brand $textType,
  voltage $textType,
  ampHours $realType,
  platform $textType,
  condition $textType,
  compatibleTools $textNullable,
  notes $textNullable,
  createdAt $textType
)
''');

    await db.execute('''
CREATE TABLE chargers (
  id $idType,
  brand $textType,
  voltageSupported $textType,
  slots $intType,
  notes $textNullable,
  createdAt $textType
)
''');

    await db.execute('''
CREATE TABLE maintenance_records (
  id $idType,
  toolId $textType,
  date $textType,
  type $textType,
  notes $textType,
  cost $realNullable,
  FOREIGN KEY (toolId) REFERENCES tools (id) ON DELETE CASCADE
)
''');

    await db.execute('''
CREATE TABLE borrow_records (
  id $idType,
  toolId $textType,
  borrowedTo $textType,
  borrowDate $textType,
  returnDate $textNullable,
  notes $textNullable,
  FOREIGN KEY (toolId) REFERENCES tools (id) ON DELETE CASCADE
)
''');
  }

  // Tools
  Future<void> insertTool(ToolItem tool) async {
    final db = await instance.database;
    await db.insert('tools', tool.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ToolItem>> getAllTools() async {
    final db = await instance.database;
    final maps = await db.query('tools', orderBy: 'createdAt DESC');
    return maps.map((map) => ToolItem.fromMap(map)).toList();
  }

  Future<void> updateTool(ToolItem tool) async {
    final db = await instance.database;
    await db.update('tools', tool.toMap(), where: 'id = ?', whereArgs: [tool.id]);
  }

  Future<void> deleteTool(String id) async {
    final db = await instance.database;
    await db.delete('tools', where: 'id = ?', whereArgs: [id]);
  }

  // Batteries
  Future<void> insertBattery(ToolBattery battery) async {
    final db = await instance.database;
    await db.insert('batteries', battery.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ToolBattery>> getAllBatteries() async {
    final db = await instance.database;
    final maps = await db.query('batteries', orderBy: 'createdAt DESC');
    return maps.map((map) => ToolBattery.fromMap(map)).toList();
  }

  Future<void> updateBattery(ToolBattery battery) async {
    final db = await instance.database;
    await db.update('batteries', battery.toMap(), where: 'id = ?', whereArgs: [battery.id]);
  }

  Future<void> deleteBattery(String id) async {
    final db = await instance.database;
    await db.delete('batteries', where: 'id = ?', whereArgs: [id]);
  }

  // Chargers
  Future<void> insertCharger(Charger charger) async {
    final db = await instance.database;
    await db.insert('chargers', charger.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Charger>> getAllChargers() async {
    final db = await instance.database;
    final maps = await db.query('chargers', orderBy: 'createdAt DESC');
    return maps.map((map) => Charger.fromMap(map)).toList();
  }

  Future<void> updateCharger(Charger charger) async {
    final db = await instance.database;
    await db.update('chargers', charger.toMap(), where: 'id = ?', whereArgs: [charger.id]);
  }

  Future<void> deleteCharger(String id) async {
    final db = await instance.database;
    await db.delete('chargers', where: 'id = ?', whereArgs: [id]);
  }

  // Maintenance Records
  Future<void> insertMaintenanceRecord(MaintenanceRecord record) async {
    final db = await instance.database;
    await db.insert('maintenance_records', record.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<MaintenanceRecord>> getMaintenanceRecordsForTool(String toolId) async {
    final db = await instance.database;
    final maps = await db.query('maintenance_records', where: 'toolId = ?', whereArgs: [toolId], orderBy: 'date DESC');
    return maps.map((map) => MaintenanceRecord.fromMap(map)).toList();
  }

  // Borrow Records
  Future<void> insertBorrowRecord(BorrowRecord record) async {
    final db = await instance.database;
    await db.insert('borrow_records', record.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<BorrowRecord>> getBorrowRecordsForTool(String toolId) async {
    final db = await instance.database;
    final maps = await db.query('borrow_records', where: 'toolId = ?', whereArgs: [toolId], orderBy: 'borrowDate DESC');
    return maps.map((map) => BorrowRecord.fromMap(map)).toList();
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
