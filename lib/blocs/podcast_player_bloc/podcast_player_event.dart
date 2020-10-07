part of 'podcast_player_bloc.dart';

@immutable
abstract class PodcastPlayerEvent {
  const PodcastPlayerEvent();
}

class InitPodcastEvent extends PodcastPlayerEvent {
  final Podcast podcast;

  const InitPodcastEvent({
    @required this.podcast,
  }) : assert(podcast != null);
}

class PlayPodcastEvent extends PodcastPlayerEvent {
  const PlayPodcastEvent();
}

class PausePodcastEvent extends PodcastPlayerEvent {
  const PausePodcastEvent();
}

class StopPodcastEvent extends PodcastPlayerEvent {
  const StopPodcastEvent();
}

class SeekPodcastEvent extends PodcastPlayerEvent {
  final double seconds;

  const SeekPodcastEvent({
    @required this.seconds,
  }) : assert(seconds != null);
}

class SetSpeedPodcastEvent extends PodcastPlayerEvent {
  final double speed;

  const SetSpeedPodcastEvent({
    @required this.speed,
  }) : assert(speed != null);
}

class CompletedPodcastEvent extends PodcastPlayerEvent {
  const CompletedPodcastEvent();
}
