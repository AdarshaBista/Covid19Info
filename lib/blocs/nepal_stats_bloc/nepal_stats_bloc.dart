import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/nepal_count.dart';

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
    if (event is GetStatsEvent) {
      yield LoadingNepalStatsState();
      try {
        NepalCount nepalStats =
            await apiService.fetchNepalCount();
        yield LoadedNepalStatsState(nepalStats: nepalStats);
      } on AppError catch (e) {
        print(e.error);
        yield ErrorNepalStatsState(message: e.message);
      }
    }
  }
}
