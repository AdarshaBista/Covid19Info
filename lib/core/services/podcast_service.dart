import 'package:just_audio/just_audio.dart';

import 'package:covid19_info/core/models/podcast.dart';
import 'package:covid19_info/core/models/app_error.dart';

class PodcastService {
  AudioPlayer _player;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  double _speed = 1.0;
  double get speed => _speed;

  Duration _duration;
  Duration get duration => _duration;

  Stream<Duration> get durationStream => _player.getPositionStream();

  Future<void> init(Podcast podcast) async {
    _player = AudioPlayer();
    _isPlaying = false;

    try {
      _duration = await _player.setUrl(podcast.audioUrl);
    } catch (e) {
      throw AppError(
        error: e.toString(),
        message: 'Couldn\'t load podcast.',
      );
    }
  }

  Future<void> play() async {
    _isPlaying = true;
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
    _isPlaying = false;
  }

  Future<void> stop() async {
    await _player.stop();
    _isPlaying = false;
    _player.dispose();
  }

  Future<void> seekTo(Duration duration) async {
    await _player.seek(duration);
  }

  Future<void> setSpeed(double speed) async {
    _speed = speed;
    await _player.setSpeed(_speed);
  }
}
