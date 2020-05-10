import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/podcast.dart';
import 'package:covid19_info/core/models/app_error.dart';

import 'package:covid19_info/core/services/podcast_service.dart';

part 'podcast_player_event.dart';
part 'podcast_player_state.dart';

class PodcastPlayerBloc extends Bloc<PodcastPlayerEvent, PodcastPlayerState> {
  final PodcastService podcastService;

  PodcastPlayerBloc({
    @required this.podcastService,
  }) : assert(podcastService != null);

  @override
  PodcastPlayerState get initialState => InitialPodcastPlayerState();

  @override
  Stream<PodcastPlayerState> mapEventToState(
    PodcastPlayerEvent event,
  ) async* {
    if (event is PlayPodcastEvent) {
      yield LoadingPodcastPlayerState();
      try {
        await podcastService.init(event.podcast);
        yield LoadedPodcastPlayerState(
          podcast: event.podcast,
          duration: const Duration(seconds: 90),
        );
        podcastService.play();
      } on AppError catch (e) {
        yield ErrorPodcastPlayerState(message: e.message);
      }
    }

    if (event is PausePodcastEvent) {
      await podcastService.pause();
      yield InitialPodcastPlayerState();
    }
  }
}
