import 'dart:io';
import 'package:dio/dio.dart';
import '../models/evidence_item.dart';
import '../../../core/services/token_manager.dart';

class EvidenceApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8000/api/v1',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  EvidenceApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenManager.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<Map<String, dynamic>?> uploadEvidence(EvidenceItem item) async {
    try {
      File file = File(item.path);
      if (!await file.exists()) return null;

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(item.path, filename: item.path.split('/').last),
        'evidence_type': item.type.toString().split('.').last,
        'lat': item.location?.split(',').first.trim(),
        'lng': item.location?.split(',').last.trim(),
        'timestamp': item.timestamp.toIso8601String(),
      });

      Response response = await _dio.post('/evidence/upload', data: formData);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  Future<List<EvidenceItem>> fetchRemoteEvidence() async {
    try {
      Response response = await _dio.get('/evidence/list');
      List<dynamic> data = response.data;
      return data.map((json) {
        return EvidenceItem(
          id: json['id'],
          type: _parseType(json['type']),
          path: json['file_url'],
          timestamp: DateTime.parse(json['timestamp']),
          location: "${json['location_lat']}, ${json['location_lng']}",
          description: "Forensic Hash: ${json['file_hash'].toString().substring(0, 8)}...",
          isSynced: true,
        );
      }).toList();
    } catch (e) {
      return [];
    }
  }

  EvidenceType _parseType(String type) {
    switch (type) {
      case 'audio': return EvidenceType.audio;
      case 'video': return EvidenceType.video;
      case 'photo': return EvidenceType.photo;
      default: return EvidenceType.other;
    }
  }
}
