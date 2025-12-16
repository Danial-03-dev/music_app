import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_local_repository.g.dart';

@Riverpod(keepAlive: true)
AuthLocalRepository authLocalRepository(Ref ref) {
  return AuthLocalRepository();
}

class AuthLocalRepository {
  final key = 'x-auth-token';
  SharedPreferences? _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  void setToken(String? token) {
    if (token == null) {
      return;
    }

    _sharedPreferences!.setString(key, token);
  }

  String? getToken() {
    return _sharedPreferences!.getString(key);
  }
}
