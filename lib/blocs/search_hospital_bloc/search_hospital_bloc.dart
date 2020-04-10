import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:rxdart/rxdart.dart';

import 'package:covid19_info/core/models/hospital.dart';
import 'package:covid19_info/blocs/hospital_bloc/hospital_bloc.dart';

part 'search_hospital_event.dart';
part 'search_hospital_state.dart';

class SearchHospitalBloc extends Bloc<SearchHospitalEvent, SearchHospitalState> {
  final HospitalBloc hospitalBloc;

  SearchHospitalBloc({
    @required this.hospitalBloc,
  }) : assert(hospitalBloc != null);

  @override
  Stream<SearchHospitalState> transformEvents(
    Stream<SearchHospitalEvent> events,
    Stream<SearchHospitalState> Function(SearchHospitalEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  SearchHospitalState get initialState => InitialSearchHospitalState();

  @override
  Stream<SearchHospitalState> mapEventToState(
    SearchHospitalEvent event,
  ) async* {
    if (event is StartHospitalSearchEvent) {
      if (event.searchTerm.isEmpty) {
        yield InitialSearchHospitalState();
      }

      yield LoadingSearchHospitalState();

      final List<Hospital> searchedHospitals = (hospitalBloc.state as LoadedHospitalState)
          .hospitals
          .where((h) => h.name.toLowerCase().contains(event.searchTerm.toLowerCase()))
          .toList();

      if (searchedHospitals.isEmpty) {
        yield EmptySearchHospitalState();
      }

      yield LoadedSearchHospitalState(searchedHospitals: searchedHospitals);
    }
  }
}
