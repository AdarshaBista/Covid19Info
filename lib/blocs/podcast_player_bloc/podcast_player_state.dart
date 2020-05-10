part of 'podcast_player_bloc.dart';

@immutable
abstract class PodcastPlayerState {}

class InitialPodcastPlayerState extends PodcastPlayerState {}

class LoadingPodcastPlayerState extends PodcastPlayerState {}

class LoadedPodcastPlayerState extends PodcastPlayerState {
  final Podcast podcast;
  final Duration duration;

  LoadedPodcastPlayerState({
    @required this.podcast,
    @required this.duration,
  })  : assert(podcast != null),
        assert(duration != null);
}

class ErrorPodcastPlayerState extends PodcastPlayerState {
  final String message;

  ErrorPodcastPlayerState({
    @required this.message,
  }) : assert(message != null);
}
