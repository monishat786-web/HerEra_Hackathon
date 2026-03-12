import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/evidence_item.dart';

class EvidenceStorageService {
  static const String _storageKey = 'herera_evidence_items';

  Future<void> saveEvidence(EvidenceItem item) async {
    final items = await getEvidenceItems();
    items.add(item);
    await _saveItems(items);
  }

  Future<List<EvidenceItem>> getEvidenceItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_storageKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => EvidenceItem.fromMap(e)).toList();
  }

  Future<void> _saveItems(List<EvidenceItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = json.encode(items.map((e) => e.toMap()).toList());
    await prefs.setString(_storageKey, jsonString);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
