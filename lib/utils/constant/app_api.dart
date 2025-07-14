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
  static String languages = '$baseUrl/auth/languages';

  /// Profile Flow

  static String editProfile = '$baseUrl/edit-profile';
  static String editUserLanguage = '$baseUrl/edit-user-language';

  /// Blog Flow
  static String blogList = '$baseUrl/blogs?title=';

  /// Pricing Flow
  static String plans = '$baseUrl/plans/category/';
  static String payment = '$baseUrl/payment/callback';

  /// Auth Category
  static String authCategory = '$baseUrl/auth/categories';

  /// Event Flow
  static String getEvent = '$baseUrl/events?title=&page=';
  static String joinEvent = '$baseUrl/events/';

  /// Task Flow
  static String userTasks = '$baseUrl/user-tasks';

  /// Graph Flow
  static String report = '$baseUrl/user-tasks/report/';

  /// User Flow
  static String user = '$baseUrl/users/';
}
