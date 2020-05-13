import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';

import 'package:covid19_info/core/models/podcast.dart';
import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/podcast_player_data.dart';

class PodcastPlayerService {
  AudioPlayer _player = AudioPlayer();
  PodcastPlayerData state = PodcastPlayerData();

  Future<void> init(Podcast podcast) async {
    state.isPlaying = StreamController<bool>.broadcast()..add(false);
    await stop();

    int result = await _player.setUrl(podcast.audioUrl);
    if (result != 1) throw AppError(message: 'Couldn\'t play podcast.');

    state.speed = 1.0;
    state.currentPodcast = podcast;
    state.currentPosition = _player.onAudioPositionChanged;
    _player.onDurationChanged.listen((Duration d) {
      state.duration = d;
    });

    MediaNotification.setListener('play', () {
      play();
    });

    MediaNotification.setListener('pause', () {
      pause();
    });
  }

  Future<void> play() async {
    state.isPlaying.add(true);
    await _player.play(state.currentPodcast.audioUrl);
    _showNotification(true);
  }

  Future<void> pause() async {
    state.isPlaying.add(false);
    await _player.pause();
    _showNotification(false);
  }

  Future<void> stop() async {
    state.isPlaying.add(false);
    await _player.stop();
    _hideNotification();
  }

  void seekTo(Duration duration) {
    _player.seek(duration);
  }

  Future<void> setSpeed(double speed) async {
    state.speed = speed;
    await _player.setPlaybackRate(playbackRate: speed);
  }

  Future<void> _hideNotification() async {
    await MediaNotification.hideNotification();
  }

  Future<void> _showNotification(bool playing) async {
    await MediaNotification.showNotification(
      title: state.currentPodcast.title,
      author: state.currentPodcast.source,
      isPlaying: playing,
    );
  }
}
