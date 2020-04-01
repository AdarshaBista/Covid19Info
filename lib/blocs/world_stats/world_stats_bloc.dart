import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/world_infection_data.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'world_stats_event.dart';
part 'world_stats_state.dart';

class WorldStatsBloc extends Bloc<WorldStatsEvent, WorldStatsState> {
  final ApiService apiService;

  WorldStatsBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  WorldStatsState get initialState => InitialWorldStatsState();

  @override
  Stream<WorldStatsState> mapEventToState(
    WorldStatsEvent event,
  ) async* {
    if (event is GetWorldStatsEvent) {
      yield LoadingWorldStatsState();
      try {
        WorldInfectionData worldStats =
            await apiService.fetchWorldInfectionData();
        yield LoadedWorldStatsState(worldStats: worldStats);
      } on AppError catch (e) {
        print(e.error);
        yield ErrorWorldStatsState(message: e.message);
      }
    }
  }
}
