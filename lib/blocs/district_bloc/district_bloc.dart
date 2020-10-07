import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:rxdart/rxdart.dart';

import 'package:covid19_info/core/models/district.dart';
import 'package:covid19_info/core/models/app_error.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'district_event.dart';
part 'district_state.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  final ApiService apiService;
  final List<District> _districts = [];

  DistrictBloc({
    @required this.apiService,
  })  : assert(apiService != null),
        super(const InitialDistrictState());

  @override
  Stream<Transition<DistrictEvent, DistrictState>> transformEvents(
    Stream<DistrictEvent> events,
    TransitionFunction<DistrictEvent, DistrictState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<DistrictState> mapEventToState(DistrictEvent event) async* {
    if (event is GetDistrictsEvent) yield* _mapGetDistrictToState();
    if (event is SearchDistrictEvent) yield* _mapSearchDistrictToState(event);
  }

  Stream<DistrictState> _mapGetDistrictToState() async* {
    yield const LoadingDistrictState();
    try {
      final List<int> districtsIds = await apiService.fetchDistrictsIds();
      for (final int id in districtsIds) {
        final district = await apiService.fetchDistrict(id);
        if (district != null) {
          _districts.add(district);
          yield LoadedDistrictState(
            shouldShowSearch: false,
            allDistricts: _districts,
            searchedDistricts: null,
          );
        }
      }
      yield LoadedDistrictState(
        allDistricts: _districts,
        searchedDistricts: null,
      );
    } on AppError catch (e) {
      print(e.error);
      yield ErrorDistrictState(message: e.message);
    }
  }

  Stream<DistrictState> _mapSearchDistrictToState(SearchDistrictEvent event) async* {
    if (event.searchTerm.isEmpty) {
      yield LoadedDistrictState(
        allDistricts: _districts,
        searchedDistricts: null,
      );
      return;
    }

    yield const LoadingDistrictState();
    final List<District> searchedDistricts = _districts
        .where((d) => d.title.toLowerCase().contains(event.searchTerm.toLowerCase()))
        .toList();

    if (searchedDistricts.isEmpty) {
      yield LoadedDistrictState(
        allDistricts: _districts,
        searchedDistricts: const [],
      );
    }
    yield LoadedDistrictState(
      allDistricts: _districts,
      searchedDistricts: searchedDistricts,
    );
  }
}
