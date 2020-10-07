part of 'podcast_bloc.dart';

@immutable
abstract class PodcastEvent {
  const PodcastEvent();
}

class GetPodcastsEvent extends PodcastEvent {
  const GetPodcastsEvent();
}
