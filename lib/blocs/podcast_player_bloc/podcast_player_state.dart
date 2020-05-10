part of 'podcast_player_bloc.dart';

@immutable
abstract class PodcastPlayerState {}

class InitialPodcastPlayerState extends PodcastPlayerState {}

class LoadingPodcastPlayerState extends PodcastPlayerState {}

class LoadedPodcastPlayerState extends PodcastPlayerState {
  final PodcastPlayerService podcastPlayerService;

  bool get isPlaying => podcastPlayerService.isPlaying;
  Duration get duration => podcastPlayerService.duration;
  Stream<Duration> get currentPosition => podcastPlayerService.currentPosition;

  LoadedPodcastPlayerState({
    @required this.podcastPlayerService,
  }) : assert(podcastPlayerService != null);
}

class ErrorPodcastPlayerState extends PodcastPlayerState {
  final String message;

  ErrorPodcastPlayerState({
    @required this.message,
  }) : assert(message != null);
}
