import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['BASE_URL'] ?? 'demo';

class AppApi {
  static String login = '$baseUrl/auth/login';
  static String register = '$baseUrl/auth/register';
  static String sendOtp = '$baseUrl/auth/send-otp';
  static String verifyOtp = '$baseUrl/auth/verify-otp';
}
