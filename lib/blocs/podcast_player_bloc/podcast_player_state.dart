part of 'podcast_player_bloc.dart';

@immutable
abstract class PodcastPlayerState {}

class InitialPodcastPlayerState extends PodcastPlayerState {}

class LoadingPodcastPlayerState extends PodcastPlayerState {}

class LoadedPodcastPlayerState extends PodcastPlayerState {
  final PodcastPlayerService podcastPlayerService;

  Podcast get currentPodcast => podcastPlayerService.currentPodcast;
  double get speed => podcastPlayerService.speed;
  bool get isPlaying => podcastPlayerService.isPlaying;
  Duration get duration => podcastPlayerService.duration;
  Stream<Duration> get currentPosition => podcastPlayerService.currentPosition;
  List<double> get speedValues => const [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

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
