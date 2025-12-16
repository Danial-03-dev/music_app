import 'package:client/core/providers/current_user/current_user_notifier.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repositories/auth_local_repository.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:fpdart/fpdart.dart' as fpdart;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;
  late CurrentUserNotifier _currentUserNotifier;

  @override
  AsyncValue<UserModel?> build() {
    _authRemoteRepository = ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository = ref.watch(authLocalRepositoryProvider);
    _currentUserNotifier = ref.watch(currentUserProvider.notifier);

    _init();

    return const AsyncValue.loading();
  }

  Future<void> _init() async {
    await _authLocalRepository.init();

    getUserData();
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

    if (!ref.mounted) return;

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

    if (!ref.mounted) return;

    state = switch (response) {
      fpdart.Left(value: final l) => AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      fpdart.Right(value: final r) => _loginSuccess(r),
    };
  }

  AsyncValue<UserModel> _loginSuccess(UserModel user) {
    _authLocalRepository.setToken(user.token);
    _currentUserNotifier.addUser(user);
    return AsyncValue.data(user);
  }

  Future<UserModel?> getUserData() async {
    state = const AsyncValue.loading();

    final token = _authLocalRepository.getToken();

    if (token == null) {
      state = const AsyncValue.data(null);
      return null;
    }

    final response = await _authRemoteRepository.getCurrentUserData(
      token: token,
    );

    if (!ref.mounted) return null;

    state = switch (response) {
      fpdart.Left(value: final l) => AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      fpdart.Right(value: final r) => _getUserDataSuccess(r),
    };

    return state.value;
  }

  AsyncValue<UserModel> _getUserDataSuccess(UserModel user) {
    _currentUserNotifier.addUser(user);
    return AsyncValue.data(user);
  }
}
