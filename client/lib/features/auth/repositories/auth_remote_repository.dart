import 'dart:convert';

import 'package:client/core/constants/server_constants.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_remote_repository.g.dart';

@riverpod
AuthRemoteRepository authRemoteRepository(Ref ref) {
  return AuthRemoteRepository();
}

class AuthRemoteRepository {
  final String _authURI = '${ServerConstants.serverURL}/auth';

  Future<fpdart.Either<Failure, UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_authURI/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      final responseBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 201) {
        return fpdart.Left(Failure(message: responseBodyMap['message']));
      }

      return fpdart.Right(UserModel.fromMap(responseBodyMap));
    } catch (e) {
      return fpdart.Left(Failure(message: e.toString()));
    }
  }

  Future<fpdart.Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_authURI/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final responseBodyMap = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        return fpdart.Left(Failure(message: responseBodyMap['message']));
      }

      return fpdart.Right(UserModel.fromMap(responseBodyMap));
    } catch (e) {
      return fpdart.Left(Failure(message: e.toString()));
    }
  }
}
