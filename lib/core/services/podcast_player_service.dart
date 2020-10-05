import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:covid19_info/core/models/podcast.dart';
import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/podcast_player_data.dart';

class PodcastPlayerService {
  static const String PLAYER_ID = 'podcast_player';

  AssetsAudioPlayer _player;

  PodcastPlayerData _state;
  PodcastPlayerData get state => _state;

  Future<void> init(Podcast podcast) async {
    _player = AssetsAudioPlayer.withId(PLAYER_ID);
    _player.onErrorDo = (handler) {
      pause();
      print(handler.error.message);
    };

    try {
      await _player.open(
        Audio.network(
          podcast.audioUrl,
          metas: Metas(
            title: podcast.title,
            artist: podcast.source,
            image: MetasImage.network(podcast.imageUrl),
          ),
        ),
        playSpeed: 1.0,
        showNotification: true,
        notificationSettings: const NotificationSettings(
          nextEnabled: false,
          prevEnabled: false,
          stopEnabled: false,
        ),
      );
    } catch (e) {
      print(e.toString());
      throw AppError(message: "Couldn't play ${podcast.title}.");
    }

    _state = PodcastPlayerData(
      speed: 1.0,
      currentPodcast: podcast,
      isPlaying: _player.isPlaying,
      currentPosition: _player.currentPosition,
      duration: _player.current.value.audio.duration,
    );
  }

  Future<void> play() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
    await _player.dispose();
  }

  Future<void> seekTo(Duration duration) async {
    await _player.seek(duration);
  }

  Future<void> setSpeed(double speed) async {
    state.speed = speed;
    await _player.setPlaySpeed(speed);
  }
}
