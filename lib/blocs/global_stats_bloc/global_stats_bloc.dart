import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/timeline_data.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'global_stats_event.dart';
part 'global_stats_state.dart';

class GlobalStatsBloc extends Bloc<GlobalStatsEvent, GlobalStatsState> {
  final ApiService apiService;

  GlobalStatsBloc({
    @required this.apiService,
  })  : assert(apiService != null),
        super(InitialGlobalStatsState());

  @override
  Stream<GlobalStatsState> mapEventToState(
    GlobalStatsEvent event,
  ) async* {
    if (event is GetGlobalStatsEvent) {
      yield LoadingGlobalStatsState();
      try {
        final List<TimelineData> globalTimeline = await apiService.fetchGlobalTimeline();
        yield LoadedGlobalStatsState(globalTimeline: globalTimeline);
      } on AppError catch (e) {
        print(e.error);
        yield ErrorGlobalStatsState(message: e.message);
      }
    }
  }
}
