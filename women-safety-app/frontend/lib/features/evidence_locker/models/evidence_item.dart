enum EvidenceType { audio, video, photo, location, other }

class EvidenceItem {
  final String id;
  final EvidenceType type;
  final String path;
  final DateTime timestamp;
  final String? location;
  final String? description;
  final bool isSynced;

  EvidenceItem({
    required this.id,
    required this.type,
    required this.path,
    required this.timestamp,
    this.location,
    this.description,
    this.isSynced = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'path': path,
      'timestamp': timestamp.toIso8601String(),
      'location': location,
      'description': description,
      'isSynced': isSynced,
    };
  }

  factory EvidenceItem.fromMap(Map<String, dynamic> map) {
    return EvidenceItem(
      id: map['id'],
      type: EvidenceType.values[map['type']],
      path: map['path'],
      timestamp: DateTime.parse(map['timestamp']),
      location: map['location'],
      description: map['description'],
      isSynced: map['isSynced'] ?? false,
    );
  }

  EvidenceItem copyWith({bool? isSynced}) {
    return EvidenceItem(
      id: id,
      type: type,
      path: path,
      timestamp: timestamp,
      location: location,
      description: description,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
