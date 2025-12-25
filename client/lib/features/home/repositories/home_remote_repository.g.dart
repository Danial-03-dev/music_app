// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_remote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeRepository)
const homeRepositoryProvider = HomeRepositoryProvider._();

final class HomeRepositoryProvider
    extends
        $FunctionalProvider<
          HomeRemoteRepository,
          HomeRemoteRepository,
          HomeRemoteRepository
        >
    with $Provider<HomeRemoteRepository> {
  const HomeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRepositoryHash();

  @$internal
  @override
  $ProviderElement<HomeRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeRemoteRepository create(Ref ref) {
    return homeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRemoteRepository>(value),
    );
  }
}

String _$homeRepositoryHash() => r'97b1d1d46f9db6fa1b9f5bdec9e833d407fa306c';
