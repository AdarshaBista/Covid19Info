part of 'podcast_bloc.dart';

@immutable
abstract class PodcastState {
  const PodcastState();
}

class InitialPodcastState extends PodcastState {
  const InitialPodcastState();
}

class LoadingPodcastState extends PodcastState {
  const LoadingPodcastState();
}

class LoadedPodcastState extends PodcastState {
  final List<Podcast> podcasts;

  const LoadedPodcastState({
    @required this.podcasts,
  }) : assert(podcasts != null);
}

class ErrorPodcastState extends PodcastState {
  final String message;

  const ErrorPodcastState({
    @required this.message,
  }) : assert(message != null);
}
