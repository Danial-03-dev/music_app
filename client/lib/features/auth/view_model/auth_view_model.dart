import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;

  @override
  AsyncValue<UserModel>? build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    return null;
  }

  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
  }) async {
    state = AsyncValue.loading();

    final response = await _authRemoteRepository.signup(
      name: name,
      email: email,
      password: password,
    );

    state = switch (response) {
      fpdart.Left(value: final l) => AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      fpdart.Right(value: final r) => AsyncValue.data(r),
    };
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    state = AsyncValue.loading();

    final response = await _authRemoteRepository.login(
      email: email,
      password: password,
    );

    state = switch (response) {
      fpdart.Left(value: final l) => AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      fpdart.Right(value: final r) => AsyncValue.data(r),
    };
  }
}
