import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/global_count.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'global_stats_event.dart';
part 'global_stats_state.dart';

class GlobalStatsBloc extends Bloc<GlobalStatsEvent, GlobalStatsState> {
  final ApiService apiService;

  GlobalStatsBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  GlobalStatsState get initialState => InitialWorldStatsState();

  @override
  Stream<GlobalStatsState> mapEventToState(
    GlobalStatsEvent event,
  ) async* {
    if (event is GetWorldStatsEvent) {
      yield LoadingWorldStatsState();
      try {
        GlobalCount worldStats = await apiService.fetchGlobalCount();
        yield LoadedWorldStatsState(worldStats: worldStats);
      } on AppError catch (e) {
        print(e.error);
        yield ErrorWorldStatsState(message: e.message);
      }
    }
  }
}
