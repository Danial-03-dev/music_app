// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAudioList)
const getAudioListProvider = GetAudioListProvider._();

final class GetAudioListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AudioModel>>,
          List<AudioModel>,
          FutureOr<List<AudioModel>>
        >
    with $FutureModifier<List<AudioModel>>, $FutureProvider<List<AudioModel>> {
  const GetAudioListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAudioListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAudioListHash();

  @$internal
  @override
  $FutureProviderElement<List<AudioModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AudioModel>> create(Ref ref) {
    return getAudioList(ref);
  }
}

String _$getAudioListHash() => r'97872ab219cf335e3115bd384b1a80268c98d79f';

@ProviderFor(getLocalAudioList)
const getLocalAudioListProvider = GetLocalAudioListProvider._();

final class GetLocalAudioListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AudioModel>>,
          List<AudioModel>,
          FutureOr<List<AudioModel>>
        >
    with $FutureModifier<List<AudioModel>>, $FutureProvider<List<AudioModel>> {
  const GetLocalAudioListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLocalAudioListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLocalAudioListHash();

  @$internal
  @override
  $FutureProviderElement<List<AudioModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AudioModel>> create(Ref ref) {
    return getLocalAudioList(ref);
  }
}

String _$getLocalAudioListHash() => r'4c4c77bc5f3b46bf9646ae57f2ed25a61ebcadf9';

@ProviderFor(HomeViewModel)
const homeViewModelProvider = HomeViewModelProvider._();

final class HomeViewModelProvider
    extends $NotifierProvider<HomeViewModel, AsyncValue<dynamic>?> {
  const HomeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeViewModelHash();

  @$internal
  @override
  HomeViewModel create() => HomeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<dynamic>?>(value),
    );
  }
}

String _$homeViewModelHash() => r'd45b176d29d9003d1560e41dc31932722631269e';

abstract class _$HomeViewModel extends $Notifier<AsyncValue<dynamic>?> {
  AsyncValue<dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<dynamic>?, AsyncValue<dynamic>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<dynamic>?, AsyncValue<dynamic>?>,
              AsyncValue<dynamic>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
