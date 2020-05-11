import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';

import 'package:covid19_info/core/models/podcast.dart';
import 'package:covid19_info/core/models/app_error.dart';

class PodcastPlayerService {
  AudioPlayer _player = AudioPlayer();

  Podcast _currentPodcast;
  Podcast get currentPodcast => _currentPodcast;

  double _speed;
  double get speed => _speed;

  StreamController _isPlaying;
  Stream<bool> get isPlaying => _isPlaying.stream;

  Duration _duration;
  Duration get duration => _duration;

  Stream<Duration> get currentPosition => _player.onAudioPositionChanged;

  Future<void> init(Podcast podcast) async {
    _isPlaying = StreamController<bool>.broadcast()..add(false);
    await stop();

    int result = await _player.setUrl(podcast.audioUrl);
    if (result != 1) throw AppError(message: 'Couldn\'t play podcast.');

    _speed = 1.0;
    _currentPodcast = podcast;
    _player.onDurationChanged.listen((Duration d) {
      _duration = d;
    });

    MediaNotification.setListener('play', () {
      play();
    });

    MediaNotification.setListener('pause', () {
      pause();
    });
  }

  Future<void> play() async {
    _isPlaying.add(true);
    await _player.play(_currentPodcast.audioUrl);
    _showNotification(true);
  }

  Future<void> pause() async {
    _isPlaying.add(false);
    await _player.pause();
    _showNotification(false);
  }

  Future<void> stop() async {
    _isPlaying.add(false);
    await _player.stop();
    _hideNotification();
  }

  void seekTo(Duration duration) {
    _player.seek(duration);
  }

  Future<void> setSpeed(double speed) async {
    _speed = speed;
    await _player.setPlaybackRate(playbackRate: _speed);
  }

  Future<void> _hideNotification() async {
    await MediaNotification.hideNotification();
  }

  Future<void> _showNotification(bool playing) async {
    await MediaNotification.showNotification(
      title: _currentPodcast.title,
      author: _currentPodcast.source,
      isPlaying: playing,
    );
  }

  void dispose() {
    _isPlaying.close();
  }
}
