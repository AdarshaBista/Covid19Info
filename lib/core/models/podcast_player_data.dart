import 'dart:async';

import 'package:covid19_info/core/models/podcast.dart';

class PodcastPlayerData {
  Podcast currentPodcast;
  double speed;
  Duration duration;
  Stream<Duration> currentPosition;
  StreamController<bool> isPlaying;

  PodcastPlayerData({
    this.currentPodcast,
    this.speed,
    this.duration,
    this.isPlaying,
    this.currentPosition,
  });

  List<double> get speedValues => const [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

  PodcastPlayerData copyWith({
    Podcast currentPodcast,
    double speed,
    Duration duration,
    Stream<bool> isPlaying,
    Stream<Duration> currentPosition,
  }) {
    return PodcastPlayerData(
      currentPodcast: currentPodcast ?? this.currentPodcast,
      speed: speed ?? this.speed,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }

  @override
  String toString() {
    return 'PodcastPlayerData(currentPodcast: $currentPodcast, speed: $speed, duration: $duration, isPlaying: $isPlaying, currentPosition: $currentPosition)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PodcastPlayerData &&
        o.currentPodcast == currentPodcast &&
        o.speed == speed &&
        o.duration == duration &&
        o.isPlaying == isPlaying &&
        o.currentPosition == currentPosition;
  }

  @override
  int get hashCode {
    return currentPodcast.hashCode ^
        speed.hashCode ^
        duration.hashCode ^
        isPlaying.hashCode ^
        currentPosition.hashCode;
  }
}
