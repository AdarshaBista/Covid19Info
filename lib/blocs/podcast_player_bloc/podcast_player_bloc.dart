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
    if (event is InitPodcastEvent) yield* _mapInitToState(event.podcast);
    if (event is PlayPodcastEvent) yield* _mapPlayToState();
    if (event is PausePodcastEvent) yield* _mapPauseToState();
    if (event is StopPodcastEvent) yield* _mapStopToState();
    if (event is SeekPodcastEvent) yield* _mapSeekToState(event.seconds);
    if (event is SetSpeedPodcastEvent) yield* _mapSetSpeedToState(event.speed);
  }

  Stream<PodcastPlayerState> _mapInitToState(Podcast podcast) async* {
    yield LoadingPodcastPlayerState();
    try {
      await podcastService.init(podcast);
      podcastService.play();
      yield LoadedPodcastPlayerState(
        podcastService: podcastService,
      );
    } on AppError catch (e) {
      yield ErrorPodcastPlayerState(message: e.message);
      yield InitialPodcastPlayerState();
    }
  }

  Stream<PodcastPlayerState> _mapPlayToState() async* {
    podcastService.play();
    yield LoadedPodcastPlayerState(
      podcastService: podcastService,
    );
  }

  Stream<PodcastPlayerState> _mapPauseToState() async* {
    await podcastService.pause();
    yield LoadedPodcastPlayerState(
      podcastService: podcastService,
    );
  }

  Stream<PodcastPlayerState> _mapStopToState() async* {
    await podcastService.stop();
    yield InitialPodcastPlayerState();
  }

  Stream<PodcastPlayerState> _mapSeekToState(double seconds) async* {
    await podcastService.seekTo(Duration(seconds: seconds.toInt()));
    yield LoadedPodcastPlayerState(
      podcastService: podcastService,
    );
  }

  Stream<PodcastPlayerState> _mapSetSpeedToState(double speed) async* {
    await podcastService.setSpeed(speed);
    yield LoadedPodcastPlayerState(
      podcastService: podcastService,
    );
  }
}