import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:rxdart/rxdart.dart';

import 'package:covid19_info/core/models/district.dart';
import 'package:covid19_info/core/models/app_error.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'nepal_district_event.dart';
part 'nepal_district_state.dart';

class NepalDistrictBloc extends Bloc<NepalDistrictEvent, NepalDistrictState> {
  final ApiService apiService;
  List<District> _districts = [];

  NepalDistrictBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  Stream<Transition<NepalDistrictEvent, NepalDistrictState>> transformEvents(
    Stream<NepalDistrictEvent> events,
    TransitionFunction<NepalDistrictEvent, NepalDistrictState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      transitionFn,
    );
  }

  @override
  NepalDistrictState get initialState => InitialDistrictState();

  @override
  Stream<NepalDistrictState> mapEventToState(NepalDistrictEvent event) async* {
    if (event is GetDistrictEvent) yield* _mapGetDistrictToState();
    if (event is SearchDistrictEvent) yield* _mapSearchDistrictToState(event);
  }

  Stream<NepalDistrictState> _mapGetDistrictToState() async* {
    yield LoadingDistrictState();
    try {
      final List<int> districtsIds = await apiService.fetchDistrictsIds();
      for (int id in districtsIds) {
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
        shouldShowSearch: true,
        allDistricts: _districts,
        searchedDistricts: null,
      );
    } on AppError catch (e) {
      print(e.error);
      yield ErrorDistrictState(message: e.message);
    }
  }

  Stream<NepalDistrictState> _mapSearchDistrictToState(SearchDistrictEvent event) async* {
    if (event.searchTerm.isEmpty) {
      yield LoadedDistrictState(
        allDistricts: _districts,
        searchedDistricts: null,
      );
      return;
    }

    yield LoadingDistrictState();
    final List<District> searchedDistricts = _districts
        .where((d) => d.title.toLowerCase().contains(event.searchTerm.toLowerCase()))
        .toList();

    if (searchedDistricts.isEmpty) {
      yield LoadedDistrictState(
        allDistricts: _districts,
        searchedDistricts: [],
      );
    }
    yield LoadedDistrictState(
      allDistricts: _districts,
      searchedDistricts: searchedDistricts,
    );
  }
}
