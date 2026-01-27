import 'package:client/features/home/models/audio_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_local_repository.g.dart';

@Riverpod(keepAlive: true)
Future<Box> homeBox(Ref ref) async {
  final box = await Hive.openBox(HomeLocalRepository.homeRepositoryBox);

  ref.onDispose(() {
    box.close();
  });

  return box;
}

@riverpod
Future<HomeLocalRepository> homeLocalRepository(Ref ref) async {
  final box = await ref.watch(homeBoxProvider.future);
  return HomeLocalRepository(box: box);
}

class HomeLocalRepository {
  static const homeRepositoryBox = 'homeRepositoryBox';

  final Box box;

  HomeLocalRepository({required this.box});

  void uploadLocalAudio(AudioModel audio) {
    try {
      box.put(audio.id, audio.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteAudio(String audioId) {
    try {
      box.delete(audioId);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<AudioModel> loadLocalAudios() {
    List<AudioModel> audios = [];

    try {
      for (final key in box.keys) {
        final data = box.get(key);

        final audio = AudioModel.fromJson(data);
        audios.add(audio);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return audios;
  }

  void clearLocalAudios() {
    try {
      box.clear();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
