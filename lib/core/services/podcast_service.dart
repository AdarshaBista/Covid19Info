import 'package:just_audio/just_audio.dart';

import 'package:covid19_info/core/models/podcast.dart';
import 'package:covid19_info/core/models/app_error.dart';

class PodcastService {
  final AudioPlayer player = AudioPlayer();

  Duration _duration;
  Duration get duration => _duration;

  Future<void> init(Podcast podcast) async {
    try {
      _duration = await player.setUrl('podcast.audioUrl');
    } catch (e) {
      throw AppError(
        error: e.toString(),
        message: 'Couldn\'t load podcast.',
      );
    }
  }

  Future<void> play() async {
    await player.play();
  }

  Future<void> pause() async {
    await player.pause();
  }
}
