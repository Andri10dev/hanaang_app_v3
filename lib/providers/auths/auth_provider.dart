import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/providers/auths/local_storage_provider.dart';
import 'package:hanaang_app/services/authenticate/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final loginProvider = FutureProvider.family<Map<String, dynamic>, LoginParams>(
    (ref, params) async {
  final authService = ref.watch(authServiceProvider);
  return authService.login(params.email, params.password);
});

final logoutProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final token = ref.watch(getTokenProvider);
  final authService = ref.watch(authServiceProvider);
  return authService.logout(token);
});

class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginParams &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password;

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
