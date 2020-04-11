part of 'country_bloc.dart';

@immutable
abstract class CountryState {}

class InitialCountryState extends CountryState {}

class LoadingCountryState extends CountryState {}

class LoadedCountryState extends CountryState {
  final List<Country> allCountries;
  final List<Country> searchedCountries;

  bool get shouldShowAllCountries => searchedCountries == null;
  bool get isSearchEmpty => searchedCountries.isEmpty;
  bool isCountryInSearch(Country c) {
    if (shouldShowAllCountries) {
      return false;
    }
    return searchedCountries.contains(c);
  }

  LoadedCountryState({
    @required this.allCountries,
    @required this.searchedCountries,
  }) : assert(allCountries != null);
}

class ErrorCountryState extends CountryState {
  final String message;

  ErrorCountryState({
    @required this.message,
  }) : assert(message != null);
}
