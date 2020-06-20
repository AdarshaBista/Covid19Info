import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/podcast.dart';
import 'package:covid19_info/core/models/app_error.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'podcast_event.dart';
part 'podcast_state.dart';

class PodcastBloc extends Bloc<PodcastEvent, PodcastState> {
  final ApiService apiService;

  PodcastBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  PodcastState get initialState => InitialPodcastState();

  @override
  Stream<PodcastState> mapEventToState(
    PodcastEvent event,
  ) async* {
    if (event is GetPodcastEvent) {
      yield LoadingPodcastState();
      try {
        final List<Podcast> podcasts = await apiService.fetchPodcasts(0);
        yield LoadedPodcastState(
          podcasts: podcasts,
        );
      } on AppError catch (e) {
        print(e.error);
        yield ErrorPodcastState(message: e.message);
      }
    }
  }
}
