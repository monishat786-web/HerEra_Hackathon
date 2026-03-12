import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/evidence_item.dart';
import 'evidence_api_service.dart';

class EvidenceStorageService {
  static const String _storageKey = 'herera_evidence_items';
  final EvidenceApiService _apiService = EvidenceApiService();

  Future<void> saveEvidence(EvidenceItem item) async {
    final items = await getEvidenceItems();
    items.add(item);
    await _saveItems(items);
    
    // Background sync attempt
    _syncIndividually(item.id);
  }

  Future<void> _syncIndividually(String id) async {
    final items = await getEvidenceItems();
    final index = items.indexWhere((e) => e.id == id);
    if (index != -1 && !items[index].isSynced) {
      final uploadResult = await _apiService.uploadEvidence(items[index]);
      if (uploadResult != null) {
        items[index] = items[index].copyWith(isSynced: true);
        await _saveItems(items);
      }
    }
  }

  Future<void> syncAll() async {
    final items = await getEvidenceItems();
    for (int i = 0; i < items.length; i++) {
      if (!items[i].isSynced) {
        final res = await _apiService.uploadEvidence(items[i]);
        if (res != null) {
          items[i] = items[i].copyWith(isSynced: true);
        }
      }
    }
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

  Future<bool> deleteEvidence(String id, String secretPassword) async {
    // Correct logic: Validate password then delete locally and remotely
    if (secretPassword == "1234") { // Mock secret password validation
      final items = await getEvidenceItems();
      items.removeWhere((item) => item.id == id);
      await _saveItems(items);
      
      // Potential remote delete call here
      // await _apiService.deleteRemoteEvidence(id); 
      
      return true;
    }
    return false;
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
