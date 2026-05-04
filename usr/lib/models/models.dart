class ToolItem {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String? size;
  final String? model;
  final String? serialNumber;
  final String? location;
  final String condition;
  final double? price;
  final DateTime? purchaseDate;
  final int? warrantyMonths;
  final String? notes;
  final String? photoPath;

  final bool isBorrowed;
  final String? borrowedTo;
  final DateTime? borrowDate;

  final DateTime? calibrationDate;
  final int? maintenanceIntervalMonths;
  final DateTime? nextMaintenanceDate;

  final DateTime createdAt;

  ToolItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    this.size,
    this.model,
    this.serialNumber,
    this.location,
    required this.condition,
    this.price,
    this.purchaseDate,
    this.warrantyMonths,
    this.notes,
    this.photoPath,
    this.isBorrowed = false,
    this.borrowedTo,
    this.borrowDate,
    this.calibrationDate,
    this.maintenanceIntervalMonths,
    this.nextMaintenanceDate,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'size': size,
      'model': model,
      'serialNumber': serialNumber,
      'location': location,
      'condition': condition,
      'price': price,
      'purchaseDate': purchaseDate?.toIso8601String(),
      'warrantyMonths': warrantyMonths,
      'notes': notes,
      'photoPath': photoPath,
      'isBorrowed': isBorrowed ? 1 : 0,
      'borrowedTo': borrowedTo,
      'borrowDate': borrowDate?.toIso8601String(),
      'calibrationDate': calibrationDate?.toIso8601String(),
      'maintenanceIntervalMonths': maintenanceIntervalMonths,
      'nextMaintenanceDate': nextMaintenanceDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ToolItem.fromMap(Map<String, dynamic> map) {
    return ToolItem(
      id: map['id'],
      name: map['name'],
      brand: map['brand'],
      category: map['category'],
      size: map['size'],
      model: map['model'],
      serialNumber: map['serialNumber'],
      location: map['location'],
      condition: map['condition'],
      price: map['price'],
      purchaseDate: map['purchaseDate'] != null ? DateTime.parse(map['purchaseDate']) : null,
      warrantyMonths: map['warrantyMonths'],
      notes: map['notes'],
      photoPath: map['photoPath'],
      isBorrowed: map['isBorrowed'] == 1,
      borrowedTo: map['borrowedTo'],
      borrowDate: map['borrowDate'] != null ? DateTime.parse(map['borrowDate']) : null,
      calibrationDate: map['calibrationDate'] != null ? DateTime.parse(map['calibrationDate']) : null,
      maintenanceIntervalMonths: map['maintenanceIntervalMonths'],
      nextMaintenanceDate: map['nextMaintenanceDate'] != null ? DateTime.parse(map['nextMaintenanceDate']) : null,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  ToolItem copyWith({
    String? id,
    String? name,
    String? brand,
    String? category,
    String? size,
    String? model,
    String? serialNumber,
    String? location,
    String? condition,
    double? price,
    DateTime? purchaseDate,
    int? warrantyMonths,
    String? notes,
    String? photoPath,
    bool? isBorrowed,
    String? borrowedTo,
    DateTime? borrowDate,
    DateTime? calibrationDate,
    int? maintenanceIntervalMonths,
    DateTime? nextMaintenanceDate,
    DateTime? createdAt,
  }) {
    return ToolItem(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      size: size ?? this.size,
      model: model ?? this.model,
      serialNumber: serialNumber ?? this.serialNumber,
      location: location ?? this.location,
      condition: condition ?? this.condition,
      price: price ?? this.price,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      warrantyMonths: warrantyMonths ?? this.warrantyMonths,
      notes: notes ?? this.notes,
      photoPath: photoPath ?? this.photoPath,
      isBorrowed: isBorrowed ?? this.isBorrowed,
      borrowedTo: borrowedTo ?? this.borrowedTo,
      borrowDate: borrowDate ?? this.borrowDate,
      calibrationDate: calibrationDate ?? this.calibrationDate,
      maintenanceIntervalMonths: maintenanceIntervalMonths ?? this.maintenanceIntervalMonths,
      nextMaintenanceDate: nextMaintenanceDate ?? this.nextMaintenanceDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ToolBattery {
  final String id;
  final String brand;
  final String voltage;
  final double ampHours;
  final String platform;
  final String condition;
  final String? compatibleTools;
  final String? notes;
  final DateTime createdAt;

  ToolBattery({
    required this.id,
    required this.brand,
    required this.voltage,
    required this.ampHours,
    required this.platform,
    required this.condition,
    this.compatibleTools,
    this.notes,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'voltage': voltage,
      'ampHours': ampHours,
      'platform': platform,
      'condition': condition,
      'compatibleTools': compatibleTools,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ToolBattery.fromMap(Map<String, dynamic> map) {
    return ToolBattery(
      id: map['id'],
      brand: map['brand'],
      voltage: map['voltage'],
      ampHours: map['ampHours'],
      platform: map['platform'],
      condition: map['condition'],
      compatibleTools: map['compatibleTools'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  ToolBattery copyWith({
    String? id,
    String? brand,
    String? voltage,
    double? ampHours,
    String? platform,
    String? condition,
    String? compatibleTools,
    String? notes,
    DateTime? createdAt,
  }) {
    return ToolBattery(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      voltage: voltage ?? this.voltage,
      ampHours: ampHours ?? this.ampHours,
      platform: platform ?? this.platform,
      condition: condition ?? this.condition,
      compatibleTools: compatibleTools ?? this.compatibleTools,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class Charger {
  final String id;
  final String brand;
  final String voltageSupported;
  final int slots;
  final String? notes;
  final DateTime createdAt;

  Charger({
    required this.id,
    required this.brand,
    required this.voltageSupported,
    required this.slots,
    this.notes,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'voltageSupported': voltageSupported,
      'slots': slots,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Charger.fromMap(Map<String, dynamic> map) {
    return Charger(
      id: map['id'],
      brand: map['brand'],
      voltageSupported: map['voltageSupported'],
      slots: map['slots'],
      notes: map['notes'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Charger copyWith({
    String? id,
    String? brand,
    String? voltageSupported,
    int? slots,
    String? notes,
    DateTime? createdAt,
  }) {
    return Charger(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      voltageSupported: voltageSupported ?? this.voltageSupported,
      slots: slots ?? this.slots,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class MaintenanceRecord {
  final String id;
  final String toolId;
  final DateTime date;
  final String type;
  final String notes;
  final double? cost;

  MaintenanceRecord({
    required this.id,
    required this.toolId,
    required this.date,
    required this.type,
    required this.notes,
    this.cost,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'toolId': toolId,
      'date': date.toIso8601String(),
      'type': type,
      'notes': notes,
      'cost': cost,
    };
  }

  factory MaintenanceRecord.fromMap(Map<String, dynamic> map) {
    return MaintenanceRecord(
      id: map['id'],
      toolId: map['toolId'],
      date: DateTime.parse(map['date']),
      type: map['type'],
      notes: map['notes'],
      cost: map['cost'],
    );
  }
}

class BorrowRecord {
  final String id;
  final String toolId;
  final String borrowedTo;
  final DateTime borrowDate;
  final DateTime? returnDate;
  final String? notes;

  BorrowRecord({
    required this.id,
    required this.toolId,
    required this.borrowedTo,
    required this.borrowDate,
    this.returnDate,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'toolId': toolId,
      'borrowedTo': borrowedTo,
      'borrowDate': borrowDate.toIso8601String(),
      'returnDate': returnDate?.toIso8601String(),
      'notes': notes,
    };
  }

  factory BorrowRecord.fromMap(Map<String, dynamic> map) {
    return BorrowRecord(
      id: map['id'],
      toolId: map['toolId'],
      borrowedTo: map['borrowedTo'],
      borrowDate: DateTime.parse(map['borrowDate']),
      returnDate: map['returnDate'] != null ? DateTime.parse(map['returnDate']) : null,
      notes: map['notes'],
    );
  }
}
