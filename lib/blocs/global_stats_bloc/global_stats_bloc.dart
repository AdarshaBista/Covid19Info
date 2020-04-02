import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/global_stats.dart';

import 'package:covid19_info/core/services/global_api_service.dart';

part 'global_stats_event.dart';
part 'global_stats_state.dart';

class GlobalStatsBloc extends Bloc<GlobalStatsEvent, GlobalStatsState> {
  final GlobalApiService apiService;

  GlobalStatsBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  GlobalStatsState get initialState => InitialGlobalStatsState();

  @override
  Stream<GlobalStatsState> mapEventToState(
    GlobalStatsEvent event,
  ) async* {
    if (event is GetGlobalStatsEvent) {
      yield LoadingGlobalStatsState();
      try {
        GlobalStats globalStats = await apiService.fetchGlobalStats();
        yield LoadedGlobalStatsState(globalStats: globalStats);
      } on AppError catch (e) {
        print(e.error);
        yield ErrorGlobalStatsState(message: e.message);
      }
    }
  }
}
