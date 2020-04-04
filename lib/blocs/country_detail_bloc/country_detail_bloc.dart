import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/country.dart';
import 'package:covid19_info/core/models/timeline_data.dart';

import 'package:covid19_info/core/services/global_api_service.dart';

part 'country_detail_event.dart';
part 'country_detail_state.dart';

class CountryDetailBloc extends Bloc<CountryDetailEvent, CountryDetailState> {
  final GlobalApiService apiService;

  CountryDetailBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  CountryDetailState get initialState => InitialCountryDetailState();

  @override
  Stream<CountryDetailState> mapEventToState(
    CountryDetailEvent event,
  ) async* {
    if (event is GetCountryDetailEvent) {
      yield LoadingCountryDetailState();
      try {
        final List<TimelineData> timeline =
            await apiService.fetchCountryTimeline(event.country.code);
        final Country country = event.country.copyWith(timeline: timeline);
        yield LoadedCountryDetailState(country: country);
      } on AppError catch (e) {
        print(e.error);
        yield ErrorCountryDetailState(message: e.message);
      }
    }
  }
}
