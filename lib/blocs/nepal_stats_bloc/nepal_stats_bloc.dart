import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/nepal_stats.dart';
import 'package:covid19_info/core/models/timeline_data.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'nepal_stats_event.dart';
part 'nepal_stats_state.dart';

class NepalStatsBloc extends Bloc<NepalStatsEvent, NepalStatsState> {
  final ApiService apiService;

  NepalStatsBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  NepalStatsState get initialState => InitialNepalStatsState();

  @override
  Stream<NepalStatsState> mapEventToState(
    NepalStatsEvent event,
  ) async* {
    if (event is GetNepalStatsEvent) {
      yield LoadingNepalStatsState();
      try {
        NepalStats nepalStats = await apiService.fetchNepalStats();
        List<TimelineData> nepalTimeline = await apiService.fetchNepalTimeline();
        yield LoadedNepalStatsState(
            nepalStats: nepalStats.copyWith(timeline: nepalTimeline));
      } on AppError catch (e) {
        print(e.error);
        yield ErrorNepalStatsState(message: e.message);
      }
    }
  }
}
