part of 'podcast_player_bloc.dart';

@immutable
abstract class PodcastPlayerState {
  const PodcastPlayerState();
}

class InitialPodcastPlayerState extends PodcastPlayerState {
  const InitialPodcastPlayerState();
}

class LoadingPodcastPlayerState extends PodcastPlayerState {
  final Podcast currentPodcast;

  const LoadingPodcastPlayerState({
    @required this.currentPodcast,
  }) : assert(currentPodcast != null);
}

class LoadedPodcastPlayerState extends PodcastPlayerState {
  final PodcastPlayerData playerState;

  const LoadedPodcastPlayerState({
    @required this.playerState,
  }) : assert(playerState != null);
}

class ErrorPodcastPlayerState extends PodcastPlayerState {
  final String message;

  const ErrorPodcastPlayerState({
    @required this.message,
  }) : assert(message != null);
}
