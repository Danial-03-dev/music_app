// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_local_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeBox)
const homeBoxProvider = HomeBoxProvider._();

final class HomeBoxProvider
    extends
        $FunctionalProvider<
          AsyncValue<Box<dynamic>>,
          Box<dynamic>,
          FutureOr<Box<dynamic>>
        >
    with $FutureModifier<Box<dynamic>>, $FutureProvider<Box<dynamic>> {
  const HomeBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeBoxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeBoxHash();

  @$internal
  @override
  $FutureProviderElement<Box<dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Box<dynamic>> create(Ref ref) {
    return homeBox(ref);
  }
}

String _$homeBoxHash() => r'f827410a72715ec3c49a60761ddbe6556eb52dcc';

@ProviderFor(homeLocalRepository)
const homeLocalRepositoryProvider = HomeLocalRepositoryProvider._();

final class HomeLocalRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<HomeLocalRepository>,
          HomeLocalRepository,
          FutureOr<HomeLocalRepository>
        >
    with
        $FutureModifier<HomeLocalRepository>,
        $FutureProvider<HomeLocalRepository> {
  const HomeLocalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeLocalRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeLocalRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<HomeLocalRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HomeLocalRepository> create(Ref ref) {
    return homeLocalRepository(ref);
  }
}

String _$homeLocalRepositoryHash() =>
    r'1a8da020cacf5ae7f659cfca155bf875e8c4f0bd';
