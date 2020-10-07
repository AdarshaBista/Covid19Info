import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/timeline_data.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'global_timeline_event.dart';
part 'global_timeline_state.dart';

class GlobalTimelineBloc extends Bloc<GlobalTimelineEvent, GlobalTimelineState> {
  final ApiService apiService;

  GlobalTimelineBloc({
    @required this.apiService,
  })  : assert(apiService != null),
        super(const InitialGlobalTimelineState());

  @override
  Stream<GlobalTimelineState> mapEventToState(GlobalTimelineEvent event) async* {
    if (event is GetGlobalTimelineEvent) {
      yield const LoadingGlobalTimelineState();
      try {
        final List<TimelineData> globalTimeline = await apiService.fetchGlobalTimeline();
        yield LoadedGlobalTimelineState(globalTimeline: globalTimeline);
      } on AppError catch (e) {
        print(e.error);
        yield ErrorGlobalTimelineState(message: e.message);
      }
    }
  }
}
