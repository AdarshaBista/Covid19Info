part of 'podcast_player_bloc.dart';

@immutable
abstract class PodcastPlayerEvent {}

class PlayPodcastEvent extends PodcastPlayerEvent {
  final Podcast podcast;

  PlayPodcastEvent({
    @required this.podcast,
  }) : assert(podcast != null);
}

class PausePodcastEvent extends PodcastPlayerEvent {}
