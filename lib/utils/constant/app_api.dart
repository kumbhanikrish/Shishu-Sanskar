import 'package:flutter_dotenv/flutter_dotenv.dart';

String baseUrl = dotenv.env['BASE_URL'] ?? 'demo';

class AppApi {
  /// Auth Flow
  static String login = '$baseUrl/auth/login';
  static String register = '$baseUrl/auth/register';
  static String sendOtp = '$baseUrl/auth/send-otp';
  static String verifyOtp = '$baseUrl/auth/verify-otp';
  static String forgotPassword = '$baseUrl/auth/forgot-password';
  static String resetPassword = '$baseUrl/auth/reset-password';
  static String forgotOtpVerify = '$baseUrl/auth/forgot-otp-verify';
  static String logout = '$baseUrl/auth/logout';
  static String deleteAccount = '$baseUrl/auth/delete-account';

  /// Profile Flow

  static String editProfile = '$baseUrl/edit-profile';

  /// Blog Flow
  static String blogList = '$baseUrl/blogs?title=';

  /// Pricing Flow
  static String plans = '$baseUrl/plans/category/';
  /// Auth Category
  static String authCategory = '$baseUrl/auth/categories';
}
