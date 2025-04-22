import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:8080'; // nếu dùng Android emulator

  // Đăng ký
  static Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return _processResponse(response);
  }

  // Xác nhận OTP (đăng ký hoặc quên mật khẩu)
  static Future<Map<String, dynamic>> confirmOTP(String email, String code) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/confirm'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'code': code}),
    );

    return _processResponse(response);
  }

  // Đăng nhập
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return _processResponse(response);
  }

  // Gửi yêu cầu quên mật khẩu
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/forgot-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    return _processResponse(response);
  }

  // Đặt lại mật khẩu
  static Future<Map<String, dynamic>> resetPassword(String email, String code, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/reset-password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'code': code,
        'password': newPassword,
      }),
    );

    return _processResponse(response);
  }

  // Xử lý phản hồi API
  static Map<String, dynamic> _processResponse(http.Response response) {
    final json = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return {'success': true, 'data': json};
    } else {
      return {'success': false, 'error': json['error'] ?? 'Unknown error'};
    }
  }static Future<void> logout() async {
    final url = Uri.parse('$baseUrl/logout');
    await http.post(url);
    // Hoặc xóa token lưu localStorage nếu có
  }

}
