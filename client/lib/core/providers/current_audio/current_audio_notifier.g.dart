// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_audio_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CurrentAudioNotifier)
const currentAudioProvider = CurrentAudioNotifierProvider._();

final class CurrentAudioNotifierProvider
    extends $NotifierProvider<CurrentAudioNotifier, AudioModel?> {
  const CurrentAudioNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentAudioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentAudioNotifierHash();

  @$internal
  @override
  CurrentAudioNotifier create() => CurrentAudioNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioModel?>(value),
    );
  }
}

String _$currentAudioNotifierHash() =>
    r'8f1a1c43e1998b89b792da9bd877318d5b1ddb5f';

abstract class _$CurrentAudioNotifier extends $Notifier<AudioModel?> {
  AudioModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AudioModel?, AudioModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AudioModel?, AudioModel?>,
              AudioModel?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
