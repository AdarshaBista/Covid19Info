part of 'podcast_player_bloc.dart';

@immutable
abstract class PodcastPlayerState {}

class InitialPodcastPlayerState extends PodcastPlayerState {}

class LoadingPodcastPlayerState extends PodcastPlayerState {}

class LoadedPodcastPlayerState extends PodcastPlayerState {
  final PodcastService podcastService;

  Duration get duration => podcastService.duration;
  Stream<Duration> get currentDuration => podcastService.durationStream;
  double get speed => podcastService.speed;
  bool get isPlaying => podcastService.isPlaying;

  LoadedPodcastPlayerState({
    @required this.podcastService,
  }) : assert(podcastService != null);
}

class ErrorPodcastPlayerState extends PodcastPlayerState {
  final String message;

  ErrorPodcastPlayerState({
    @required this.message,
  }) : assert(message != null);
}
