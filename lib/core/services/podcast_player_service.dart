import 'package:audioplayers/audioplayers.dart';

import 'package:covid19_info/core/models/podcast.dart';
import 'package:covid19_info/core/models/app_error.dart';

class PodcastPlayerService {
  AudioPlayer _player = AudioPlayer();

  Podcast _currentPodcast;
  Podcast get currentPodcast => _currentPodcast;

  bool _isPlaying;
  bool get isPlaying => _isPlaying;

  Duration _duration;
  Duration get duration => _duration;

  Stream<Duration> get currentPosition => _player.onAudioPositionChanged;

  Future<void> init(Podcast podcast) async {
    int result = await _player.setUrl(podcast.audioUrl);
    if (result != 1) {
      throw AppError(message: 'Couldn\'t play podcast.');
    }

    _isPlaying = false;
    _duration = Duration();
    _currentPodcast = podcast;

    _player.onDurationChanged.listen((Duration d) {
      _duration = d;
    });

    _player.onPlayerCompletion.listen((_) {
      _isPlaying = false;
      seekTo(Duration());
    });

    _player.onPlayerError.listen((message) {
      _isPlaying = false;
      _duration = Duration();
      _currentPodcast = null;

      throw AppError(
        error: message,
        message: 'Couldn\'t play podcast.',
      );
    });
  }

  Future<void> play() async {
    _isPlaying = true;
    await _player.play(_currentPodcast.audioUrl);
  }

  Future<void> pause() async {
    _isPlaying = false;
    await _player.pause();
  }

  Future<void> stop() async {
    _isPlaying = false;
    await _player.stop();
  }

  void seekTo(Duration duration) {
    _player.seek(duration);
  }

  Future<void> setSpeed(double speed) async {
    await _player.setPlaybackRate(playbackRate: speed);
  }
}
