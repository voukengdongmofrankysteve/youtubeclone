import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';
  static const String _userNameKey = 'user_name';

  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  String? _token;
  int? _userId;
  String? _userEmail;
  String? _userName;

  // Getters
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;
  String? get token => _token;
  int? get userId => _userId;
  String? get userEmail => _userEmail;
  String? get userName => _userName;

  /// Initialize auth service and load saved credentials
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(_tokenKey);
    _userId = prefs.getInt(_userIdKey);
    _userEmail = prefs.getString(_userEmailKey);
    _userName = prefs.getString(_userNameKey);
  }

  /// Save user credentials after login/register
  Future<void> saveCredentials({
    required String token,
    required int userId,
    required String email,
    String? name,
  }) async {
    _token = token;
    _userId = userId;
    _userEmail = email;
    _userName = name;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_userIdKey, userId);
    await prefs.setString(_userEmailKey, email);
    if (name != null) {
      await prefs.setString(_userNameKey, name);
    }
  }

  /// Clear all credentials (logout)
  Future<void> logout() async {
    _token = null;
    _userId = null;
    _userEmail = null;
    _userName = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userNameKey);
  }

  /// Get authorization header for API requests
  Map<String, String> getAuthHeaders() {
    if (!isAuthenticated) {
      return {};
    }
    return {
      'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
    };
  }
}
