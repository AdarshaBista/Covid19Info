import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/country.dart';

import 'package:covid19_info/core/services/global_api_service.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final GlobalApiService apiService;

  CountryBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  CountryState get initialState => InitialCountryState();

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    if (event is GetCountryEvent) {
      yield LoadingCountryState();
      try {
        final List<Country> countries = await apiService.fetchCountries();
        yield LoadedCountryState(countries: countries.where((c) => c.isValid).toList());
      } on AppError catch (e) {
        print(e.error);
        yield ErrorCountryState(message: e.message);
      }
    }
  }
}
