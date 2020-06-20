import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/myth.dart';
import 'package:covid19_info/core/models/app_error.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'myth_event.dart';
part 'myth_state.dart';

class MythBloc extends Bloc<MythEvent, MythState> {
  final ApiService apiService;

  MythBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  MythState get initialState => InitialMythState();

  @override
  Stream<MythState> mapEventToState(
    MythEvent event,
  ) async* {
    if (event is GetMythEvent) {
      yield LoadingMythState();
      try {
        final List<Myth> myths = await apiService.fetchMyths(0);
        yield LoadedMythState(
          myths: myths,
        );
      } on AppError catch (e) {
        print(e.error);
        yield ErrorMythState(message: e.message);
      }
    }
  }
}
