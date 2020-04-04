import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/app_error.dart';
import 'package:covid19_info/core/models/country.dart';
import 'package:covid19_info/core/models/country_data.dart';

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
        final List<CountryData> countriesData =
            await apiService.fetchCountriesData();

        final List<Country> countries = countriesData.map(
          (e) {
            final String code = nameToCodeMap[e.name.toLowerCase()] ?? e.name;
            return Country(
              countryData: e,
              timeline: [],
              code: code,
            );
          },
        ).toList();

        yield LoadedCountryState(countries: countries);
      } on AppError catch (e) {
        print(e.error);
        yield ErrorCountryState(message: e.message);
      }
    }
  }
}

const Map<String, String> nameToCodeMap = {
  "usa": "us",
  "taiwan": "taiwan*",
  "isle of man": "united kingdom",
  "aruba": "netherlands",
  "sint maarten": "netherlands",
  "st. vincent grenadines": "saint vincent and the grenadines",
  "timor-leste": "East Timor",
  "montserrat": "united kingdom",
  "cayman islands": "united kingdom",
  "bermuda": "united kingdom",
  "greenland": "denmark",
  "st. barth": "saint barthelemy",
  "congo": "congo (brazzaville)",
  "saint martin": "france",
  "gibraltar": "united kingdom",
  "mayotte": "france",
  "french guiana": "france",
  "u.s. virgin islands": "us",
  "curaçao": "netherlands",
  "puerto rico": "us",
  "french polynesia": "france",
  "ivory coast": "Cote d'Ivoire",
  "macao": "china",
  "drc": "congo (kinshasa)",
  "channel islands": "united kingdom",
  "réunion": "france",
  "guadeloupe": "france",
  "faeroe islands": "Denmark",
  "uae": "United Arab Emirates",
  "diamond princess": "australia",
  "hong kong": "china",
  "uk": "united kingdom",
  "car": "central african republic",
};
