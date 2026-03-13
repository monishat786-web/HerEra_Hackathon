import 'package:dio/dio.dart';
import '../../../core/services/token_manager.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:8000/api/v1/auth',
    connectTimeout: const Duration(seconds: 5),
  ));

  Future<bool> signup({
    required String email,
    required String password,
    required String secretPassword,
    String? fullName,
  }) async {
    try {
      final response = await _dio.post('/signup', data: {
        'email': email,
        'password': password,
        'secret_password': secretPassword,
        'full_name': fullName,
      });
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });
      
      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        await TokenManager.saveToken(token);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await TokenManager.deleteToken();
  }
}
