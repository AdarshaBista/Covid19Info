part of 'country_bloc.dart';

@immutable
abstract class CountryState {
  const CountryState();
}

class InitialCountryState extends CountryState {
  const InitialCountryState();
}

class LoadingCountryState extends CountryState {
  const LoadingCountryState();
}

class LoadedCountryState extends CountryState {
  final List<Country> allCountries;
  final List<Country> searchedCountries;
  final CountryFilterType filterType;

  bool get shouldShowAllCountries => searchedCountries == null;
  bool get isSearchEmpty => searchedCountries.isEmpty;
  bool isCountryInSearch(Country c) {
    if (shouldShowAllCountries) {
      return false;
    }
    return searchedCountries.contains(c);
  }

  const LoadedCountryState({
    @required this.filterType,
    @required this.allCountries,
    @required this.searchedCountries,
  })  : assert(filterType != null),
        assert(allCountries != null);
}

class ErrorCountryState extends CountryState {
  final String message;

  const ErrorCountryState({
    @required this.message,
  }) : assert(message != null);
}
