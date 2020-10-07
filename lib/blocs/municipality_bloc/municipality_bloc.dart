import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/municipality.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'municipality_event.dart';
part 'municipality_state.dart';

class MunicipalityBloc extends Bloc<MunicipalityEvent, MunicipalityState> {
  final ApiService apiService;
  final List<Municipality> _municipalities = [];

  MunicipalityBloc({
    @required this.apiService,
  })  : assert(apiService != null),
        super(const InitialMunicipalityState());

  @override
  Stream<MunicipalityState> mapEventToState(MunicipalityEvent event) async* {
    if (event is GetMunicipalityEvent) yield* _mapGetMunicipalityToState(event.ids);
  }

  Stream<MunicipalityState> _mapGetMunicipalityToState(List<int> ids) async* {
    yield const LoadingMunicipalityState();
    try {
      for (final int id in ids) {
        final municipality = await apiService.fetchMunicipality(id);
        if (municipality != null) {
          _municipalities.add(municipality);
          yield LoadedMunicipalityState(municipalities: _municipalities);
        }
      }
    } on AppError catch (e) {
      print(e.error);
      yield ErrorMunicipalityState(message: e.message);
    }
  }
}
